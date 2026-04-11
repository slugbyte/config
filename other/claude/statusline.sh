#!/usr/bin/env bash
# Claude Code status line.
#
# Minimal grayscale layout:
# directory · git branch/status · file changes · model · context usage · cost

set -u

COLOR_RESET=$'\033[0m'
COLOR_DIM=$'\033[38;2;96;96;96m'
COLOR_MUTED=$'\033[38;2;132;132;132m'
COLOR_TEXT=$'\033[38;2;176;176;176m'
COLOR_STRONG=$'\033[38;2;214;214;214m'
COLOR_WARN=$'\033[38;2;196;160;128m'
COLOR_ERROR=$'\033[38;2;220;150;150m'

format_count() {
    local value=$1
    if (( value < 1000 )); then
        printf '%s' "$value"
    elif (( value < 10000 )); then
        awk -v value="$value" 'BEGIN { printf "%.1fk", value / 1000 }'
    elif (( value < 1000000 )); then
        awk -v value="$value" 'BEGIN { printf "%dk", value / 1000 }'
    else
        awk -v value="$value" 'BEGIN { printf "%.1fM", value / 1000000 }'
    fi
}

format_cost() {
    local value=$1
    awk -v value="$value" 'BEGIN {
        if (value <= 0) printf "$0.00";
        else if (value < 0.01) printf "$%.4f", value;
        else if (value < 1) printf "$%.3f", value;
        else printf "$%.2f", value;
    }'
}

append_segment() {
    local text=$1
    if [[ -z "$text" ]]; then
        return
    fi

    if [[ -n "${segments:-}" ]]; then
        segments+=" ${COLOR_DIM}·${COLOR_RESET} "
    fi
    segments+="$text"
}

input=$(cat)

IFS=$'\t' read -r cwd model context_size context_tokens context_percent total_cost_usd total_input total_output <<< "$(
    jq -r '
        (
            .context_window.current_usage // {}
        ) as $usage |
        [
            .workspace.current_dir // .workspace.project_dir // .cwd // "",
            (if (.model | type) == "object"
                then (.model.display_name // .model.name // .model.id // "")
                else (.model // "")
             end),
            (.context_window.context_window_size // 200000),
            (
                ($usage.input_tokens // 0) +
                ($usage.output_tokens // 0) +
                ($usage.cache_creation_input_tokens // 0) +
                ($usage.cache_read_input_tokens // 0)
            ),
            (.context_window.used_percentage // 0),
            (.cost.total_cost_usd // 0),
            (.context_window.total_input_tokens // 0),
            (.context_window.total_output_tokens // 0)
        ] | @tsv
    ' <<< "$input" 2>/dev/null
)"

effort_level=""
for settings_path in "${cwd}/.claude/settings.json" "$HOME/.claude/settings.json"; do
    if [[ -f "$settings_path" ]]; then
        effort_level=$(jq -r '.effortLevel // ""' "$settings_path" 2>/dev/null)
        if [[ -n "$effort_level" && "$effort_level" != "null" ]]; then
            break
        fi
        effort_level=""
    fi
done

if [[ -z "$cwd" ]]; then
    cwd=$(pwd)
fi

cwd_name=$(basename "$cwd")
if [[ -z "$cwd_name" || "$cwd_name" == "/" ]]; then
    cwd_name="$cwd"
fi

if [[ -z "$model" || "$model" == "null" ]]; then
    model="Claude"
fi

branch_name=""
branch_color="$COLOR_MUTED"
changes_text=""
changes_color="$COLOR_MUTED"

if branch=$(git -C "$cwd" symbolic-ref --quiet --short HEAD 2>/dev/null); then
    branch_name="$branch"
elif branch=$(git -C "$cwd" rev-parse --short HEAD 2>/dev/null); then
    branch_name="@$branch"
fi

if [[ -n "$branch_name" ]]; then
    porcelain=$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null)
    if [[ -n "$porcelain" ]]; then
        branch_color="$COLOR_STRONG"
        change_count=$(printf '%s\n' "$porcelain" | sed '/^$/d' | wc -l | tr -d ' ')
        staged_count=$(printf '%s\n' "$porcelain" | awk 'substr($0,1,1) != " " && substr($0,1,1) != "?" { count++ } END { print count + 0 }')
        unstaged_count=$(printf '%s\n' "$porcelain" | awk 'substr($0,2,1) != " " && substr($0,1,2) != "??" { count++ } END { print count + 0 }')
        untracked_count=$(printf '%s\n' "$porcelain" | awk 'substr($0,1,2) == "??" { count++ } END { print count + 0 }')

        changes_parts=()
        if (( staged_count > 0 )); then
            changes_parts+=("s${staged_count}")
        fi
        if (( unstaged_count > 0 )); then
            changes_parts+=("u${unstaged_count}")
        fi
        if (( untracked_count > 0 )); then
            changes_parts+=("?${untracked_count}")
        fi

        if (( ${#changes_parts[@]} > 0 )); then
            changes_text=$(IFS=, ; printf '%s' "${changes_parts[*]}")
        elif (( change_count > 0 )); then
            changes_text="${change_count} files"
        fi

        if (( unstaged_count > 0 || untracked_count > 0 )); then
            changes_color="$COLOR_WARN"
        else
            changes_color="$COLOR_TEXT"
        fi
    fi
fi

context_color="$COLOR_TEXT"
if [[ "$context_percent" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
    context_percent_int=${context_percent%.*}
    if (( context_percent_int >= 90 )); then
        context_color="$COLOR_ERROR"
    elif (( context_percent_int >= 75 )); then
        context_color="$COLOR_WARN"
    fi
else
    context_percent_int=0
fi

context_tokens_text="?"
if [[ "$context_tokens" =~ ^[0-9]+$ ]]; then
    context_tokens_text=$(format_count "$context_tokens")
fi

context_size_text="?"
if [[ "$context_size" =~ ^[0-9]+$ ]]; then
    context_size_text=$(format_count "$context_size")
fi

cost_text=$(format_cost "$total_cost_usd")

segments=""
append_segment "${COLOR_MUTED}${cwd_name}${COLOR_RESET}"

if [[ -n "$branch_name" ]]; then
    append_segment "${branch_color}${branch_name}${COLOR_RESET}"
fi

if [[ -n "$changes_text" ]]; then
    append_segment "${changes_color}${changes_text}${COLOR_RESET}"
fi

model_segment="${COLOR_TEXT}${model}${COLOR_RESET}"
if [[ -n "$effort_level" ]]; then
    model_segment+="${COLOR_DIM}/${COLOR_RESET}${COLOR_MUTED}${effort_level}${COLOR_RESET}"
fi
append_segment "$model_segment"
append_segment "${COLOR_DIM}ctx ${COLOR_RESET}${context_color}${context_percent_int}%${COLOR_RESET}${COLOR_DIM}/${context_tokens_text}/${context_size_text}${COLOR_RESET}"

total_input_text="?"
total_output_text="?"
if [[ "$total_input" =~ ^[0-9]+$ ]]; then
    total_input_text=$(format_count "$total_input")
fi
if [[ "$total_output" =~ ^[0-9]+$ ]]; then
    total_output_text=$(format_count "$total_output")
fi
append_segment "${COLOR_DIM}tok ${COLOR_RESET}${COLOR_MUTED}${total_input_text}${COLOR_RESET}${COLOR_DIM}:${COLOR_RESET}${COLOR_MUTED}${total_output_text}${COLOR_RESET}${COLOR_DIM}/${COLOR_RESET}${COLOR_MUTED}${cost_text}${COLOR_RESET}"

printf '%b' "$segments"
