---
name: vcs
description: >
  REQUIRED for all version control work. Uses the v* scripts in ~/bin to handle
  jj and git transparently. Trigger on status, diff, log, commit, push, pull,
  describe, or any VCS request. If .jj/ exists, the scripts use jj. Otherwise git.
allowed-tools: Bash(v*), Bash(gh *), Bash(jj *), Bash(git branch*), Bash(git rebase*), Bash(git cherry-pick*)
---

# VCS Skill

Use this skill for all version control work. The `v*` scripts handle VCS
detection, GPG signing, and safety prompts automatically. Never use raw `git`
or `jj` for operations the scripts cover.

## Core Workflow

1. Get context: `vstate`
2. Commit work: `vcommit "message"`
3. Push when requested: `vpush`

## Commands

| Command   | Purpose                          | Notes                          |
|-----------|----------------------------------|--------------------------------|
| `vstate`  | Full context (status+diff+log)   | Always start here              |
| `vcommit` | Commit work                      | jj: desc+new, git: add+commit |
| `vstat`   | Status only                      |                                |
| `vdiff`   | Diff (pass-through args)         |                                |
| `vlog`    | Log (pass-through args)          |                                |
| `vdesc`   | Describe/amend without advancing | Takes message as positional arg|
| `vnew`    | New empty change (jj only)       |                                |
| `vadd`    | Stage specific files (git only)  |                                |
| `vpush`   | Push to remote                   |                                |
| `vpull`   | Pull from remote                 |                                |
| `vfetch`  | Fetch from remote                |                                |
| `vdrop`   | Abandon/reset                    | Has safety prompt              |
| `vtag`    | Create signed tag (git only)     |                                |
| `vopen`   | Open repo in browser             |                                |
| `vdetect` | Detect VCS type and repo root    |                                |

## Mandatory Rules

1. Use `v*` scripts for all standard operations. Do not use raw `git` or `jj`
   when a script exists for the operation.
2. Always run `vstate` first to understand the repo before making changes.
3. Use `vcommit "message"` to commit — do not manually run desc+new or add+commit.
4. Never force push without explicit user request.
5. Use non-interactive flags when falling back to raw commands.

## Raw Command Exceptions

Raw `jj` or `git` is allowed ONLY for operations the scripts don't cover:

- `jj show`, `jj show <revset>` — inspect a specific change
- `jj rebase`, `jj squash` — history editing
- `jj log -r <revset>` — filtered log with revset queries
- `git branch` — branch management
- `git rebase`, `git cherry-pick` — history editing
- `gh` — PRs, issues, and GitHub workflows

## Revset Quick Reference (jj)

- `@` — current working-copy change
- `@-` — parent of current change
- `@+` — children of current change
- `root()..@` — ancestors up to current change
- `heads(all())` — all heads
- `bookmarks()` — all bookmarked revisions
- `main` — revision pointed to by local `main`
- `main@origin` — remote `main` on `origin`

## PR Workflow

- Push branch: `vpush`
- Create PR: `gh pr create --title "..." --body "..."`
