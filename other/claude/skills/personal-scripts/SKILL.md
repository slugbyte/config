---
name: personal-scripts
description: >
  Conventions for creating or modifying personal scripts in ~/workspace/conf/bin.
  Trigger when adding, editing, or discussing scripts in the bin directory.
allowed-tools: Bash(chmod *), Write, Edit, Read
---

# Personal Scripts Skill

Use this skill when creating or modifying scripts in `~/workspace/conf/bin`.

## File Conventions

- Scripts have no file extension — the shebang determines the interpreter.
- Scripts must be executable (`chmod +x`).
- Bash scripts use `#!/bin/bash`. Bun scripts use `#!/usr/bin/env bun`.

## Required Flags

Every script must support two flags:

### `--describe`

A one-liner that prints a short description and exits. Must be handled
before `--help`. For bash scripts use the compact form:

```bash
[[ "$1" == "--describe" ]] && echo "Short description here" && exit 0
```

The `scripts` command uses `--describe` to build a listing of all available
scripts, so the description should be concise and useful for scanning.

### `--help`

Prints usage, options, and behavior notes, then exits. Format:

```bash
if [[ "$1" == "--help" ]]; then
    echo "Usage: scriptname [args...]"
    echo ""
    echo "What the script does."
    echo "  option      Description of option"
    echo "  -f,--flag   Description of flag"
    exit 0
fi
```

- First line is always `Usage:`.
- Blank line after usage.
- Options/args indented with two spaces, descriptions aligned.
- If VCS-aware, note the jj and git behavior separately.

## Header Comment Block

Every script starts with a header comment immediately after the shebang:

```bash
#!/bin/bash
# scriptname - Short description (matches --describe output)
#
# Longer explanation of what the script does, when to use it,
# and any important context. Keep it to 2-4 lines.
#
# Usage:
#   scriptname [args...]
#
# Examples:
#   scriptname              # basic usage
#   scriptname --flag       # with a flag
```

## VCS Scripts (v* prefix)

Scripts that wrap version control commands follow extra conventions:

- Name starts with `v` (e.g., `vstat`, `vcommit`, `vpush`).
- Use `vdetect` to determine VCS type and repo root:
  ```bash
  vcs_info=$(vdetect) || exit 1
  vcs="${vcs_info%% *}"
  ```
- Handle jj first, then git. Use `exit 0` after the jj block.
- Git commits use GPG signing (`-S` flag) and verification (`git verify-commit HEAD`).
- Use `--no-pager` for jj commands that might page.

## Style

- No unnecessary dependencies — prefer coreutils and standard tools.
- Error messages go to stderr: `echo "ERROR: ..." >&2`.
- Exit 1 on errors.
- Safety prompts before destructive operations (see `vdrop` for the pattern).
- Keep scripts focused — one script does one thing.
