# Version Control Skill
> created: 2026-04-11

## Goal

Replace the separate `git` and `jujutsu` skills with a single unified `vcs`
skill that uses the `v*` scripts in `./bin`. Agents should never run raw
`git` or `jj` commands for standard workflows — the scripts handle VCS
detection, GPG signing, safety prompts, and consistent behavior.

## Problem

- Two separate skills (`git`, `jujutsu`) teach agents to use raw commands.
- The `v*` scripts encode important decisions (GPG signing, fetch flags,
  safety prompts on `vdrop`) that the skills bypass entirely.
- Agents currently run 3 commands (`status` + `diff` + `log`) to get context
  when `vstate` now does it in one.

## Design

### Single `vcs` skill replaces both `git` and `jujutsu`

- Skill name: `vcs`
- Trigger: any version control request (status, diff, log, commit, push, pull, etc.)
- Allowed tools: `Bash(v*)`, `Bash(gh *)`
- The skill should NOT teach raw `git` or `jj` commands for standard operations.

### Core agent workflow

1. **Get context**: `vstate` (one command — status + diff + log)
2. **Commit work**: `vcommit "message"` (jj: desc + new, git: add + commit)
3. **Push**: `vpush` (handles bookmarks for jj, tags for git)

That's it. Two commands for the common case: `vstate` then `vcommit`.

### Command reference in the skill

| Command   | Purpose                          | Notes               |
|-----------|----------------------------------|----------------------|
| `vstate`  | Full context (status+diff+log)   | Always start here    |
| `vcommit` | Commit work                      | jj: desc+new, git: add+commit |
| `vstat`   | Status only                      |                      |
| `vdiff`   | Diff only (pass-through args)    |                      |
| `vlog`    | Log only (pass-through args)     |                      |
| `vdesc`   | Describe/amend without advancing |                      |
| `vnew`    | New empty change (jj only)       |                      |
| `vadd`    | Stage files (git only)           |                      |
| `vpush`   | Push to remote                   |                      |
| `vpull`   | Pull from remote                 |                      |
| `vfetch`  | Fetch from remote                |                      |
| `vdrop`   | Abandon/reset (has safety prompt)|                      |
| `vtag`    | Create signed tag (git only)     |                      |
| `vopen`   | Open repo in browser             |                      |
| `vdetect` | Detect VCS type                  | Used by other scripts|

### Fallback to raw commands

Raw `jj` or `git` allowed ONLY for operations the `v*` scripts don't cover:
- `jj show`, `jj rebase`, `jj squash`, revset queries
- `git branch`, `git rebase`, `git cherry-pick`
- `gh` for PR/issue workflows

The skill should explicitly list these as exceptions.

### jj-specific notes to keep

- Revset quick reference (useful for agents)
- `vnew` available for creating empty changes without describing
- `vdesc` available for re-describing without advancing
- Non-interactive flags required

### git-specific notes to keep

- Use `vadd` before `vnew` (staging is a git concept)
- Never force push without explicit request

## Tasks

- [x] Write the unified `vcs` SKILL.md
- [x] Archive `other/claude/skills/git/` to `other/skill-archive/git`
- [x] Archive `other/claude/skills/jujutsu/` to `other/skill-archive/jujutsu`
- [x] Create `vstate` script
- [x] Create `vcommit` script
- [x] Update `vnew` to jj-only
- [x] Update `other/pi/extensions/vcs-dirty-check.ts` to use `vdetect`/`vcommit`
- [x] Test skill triggers correctly for both jj and git repos
