# Workspace Naming Cli
> created: 2026-04-13

## Goal

Create a lightweight personal CLI for assigning human-readable labels to
numbered Hyprland workspaces without renaming the workspaces themselves.

## Findings

- Keeping workspace ids numeric preserves the current keyboard workflow and the
  existing numbered buttons in Waybar.
- A cache-backed label file per workspace is sufficient for this use case.
- Waybar can show the active workspace label with a separate `custom/*` module,
  so the stock `hyprland/workspaces` buttons can stay unchanged.

## Non-goals

- Renaming Hyprland workspaces through `hyprctl dispatch renameworkspace`.
- Replacing the numbered workspace buttons in Waybar.
- Building a TUI or persistent config format in the first pass.

## CLI

Implemented script: `bin/wname`

Supported commands:

- `wname <id> <name...>`
- `wname . <name...>`
- `wname <id>`
- `wname .`
- `wname --clear <id|.|all>`
- `wname x`
- `wname X`

Behavior:

- `.` targets the current active workspace.
- `x` clears the current active workspace label.
- `X` clears all saved labels.
- A name is stored as plain text.
- The script does not modify Hyprland workspace names.

## Storage

Store labels in the user cache directory:

- `${XDG_CACHE_HOME:-~/.cache}/custom-workspace-names/<workspace-id>`

Examples:

- `~/.cache/custom-workspace-names/1`
- `~/.cache/custom-workspace-names/2`

Rules:

- Missing file means no custom label.
- Empty or whitespace-only content is treated as unset.
- Only the first line is used for display.

## Waybar Integration

Use a separate custom module between the workspace buttons and the active
window label on the left side:

- Keep `hyprland/workspaces` using the numbered icon-based display.
- Add `custom/wname` that runs `wname .`.
- Format the label as `({text})`.
- Poll every second.
- Hide the module when the output is empty.

This keeps the numeric workspace buttons intact while exposing the active
workspace label when present.

## Risks

- Labels in `~/.cache` may be lost if the cache is manually cleaned.
- Very long labels may need follow-up CSS tuning.
- If Hyprland is unavailable, `wname .` will fail until the compositor is
  running.

## Verification

- Run `wname 2 code review` and confirm the file is written in the cache dir.
- Switch to workspace 2 and confirm Waybar shows the label between the
  workspace buttons and the active window label.
- Run `wname --clear 2` and confirm the label disappears.
- Confirm the numbered workspace buttons still show their normal numeric state,
  including active highlighting.
