---
name: jujutsu
description: >
  REQUIRED for version control work in repositories containing .jj/. If .jj/
  exists, use jj only and never git. Trigger on commit, status, diff, show,
  log, history, or any VCS request.
allowed-tools: Bash(jj *)
---

# Jujutsu (jj) Skill

Use this skill whenever version control is involved in a repository with `.jj/`.

## Mandatory Rules

1. If `.jj/` exists, never run `git` commands.
2. Use `jj` commands only.
3. Use non-interactive commands in agent environments.
4. Use inline message flags, for example: `jj desc -m "..."`.

## Minimal Workflow

This workflow is intentionally simple:

1. Check status: `jj st`
2. Set/update change description: `jj desc -m "..."`
3. Make edits.
4. Review changes: `jj diff`
5. Review history: `jj log`
6. Inspect a specific change when needed: `jj show` or `jj show <revset>`
7. Start next change when done: `jj new` (allways ask)

## Command Set

- `jj st` - status
- `jj log` - history
- `jj diff` - current change diff
- `jj show` - details for current change
- `jj show <revset>` - details for a specific revision
- `jj desc -m "..."` - set change description
- `jj new` - start a new change

## Revset Quick Reference

Revsets are jj's revision query language. They let you select exactly which
changes commands should operate on. A common use is filtering history with
`jj log -r <revset>`.

Examples:

- `jj log -r @` - show current change
- `jj log -r @-` - show parent of current change
- `jj log -r 'root()..@'` - show ancestors up to current change (excluding `root()`)
- `jj log -r 'heads(all())'` - show all heads

- `@` - current working-copy change
- `@-` - parent of current change
- `@+` - children of current change
- `root()..@` - ancestors up to current change
- `heads(all())` - all heads
- `bookmarks()` - all bookmarked revisions
- `main` - revision pointed to by local `main`
- `main@origin` - remote `main` on `origin`

## Out of Scope for This Skill

- Bookmark strategy and push conventions.
- Advanced history surgery workflows.
