---
name: vroot
description: Use this skill whenever you need the current project root path. It walks upward for .jj or .git and falls back to the current working directory when no repository markers exist.
---

# Vroot

Use `vroot` to resolve the current project root path from the shell.

## When to Use

- The user asks for a project root or repo root.
- You need to anchor commands to the top of the current project.
- You want a root path that still works outside version control.

## Command

```bash
vroot
```

It prints one path to stdout:

- nearest ancestor with `.jj`
- otherwise nearest ancestor with `.git`
- otherwise the current working directory

## Guidance

- Use `vroot` instead of hard-coding `../..` path walks.
- Treat the output as the base path for project-relative commands.
- It is safe to use in non-repository directories because it falls back to cwd.
