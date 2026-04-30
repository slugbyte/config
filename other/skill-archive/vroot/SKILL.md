---
name: vroot
description: >
  Use this skill whenever you need the project root path from the current
  directory. It applies when the user asks for a repo root, workspace root,
  top-level project path, or when commands should be anchored at the nearest
  ancestor containing .jj or .git. If no repository markers exist, use the
  current working directory.
allowed-tools: Bash(vroot)
---

# Vroot Skill

Use `vroot` to resolve the current project root path.

## When to Use

- The user asks for the repository root or project root.
- A command should run from the top of the current project.
- You need a stable base path before reading or writing project-relative files.
- The current directory might not be inside version control, but you still need
  a sensible root path.

## Command

```bash
vroot
```

This prints exactly one path:

- the nearest ancestor containing `.jj`, or
- the nearest ancestor containing `.git`, or
- the current working directory when neither marker exists.

## Guidance

- Prefer `vroot` over manually guessing path depth.
- Use the returned path directly in scripts and shell commands.
- Do not assume the project root is the same as the current directory.
- Do not fail just because the directory is not version-controlled.
