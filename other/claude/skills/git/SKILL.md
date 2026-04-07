---
name: git
description: >
  Use for git workflows when a repository is git-only. If .jj/ exists, defer
  to the jujutsu skill and do not run git commands. Trigger on status, diff,
  log, commit, branch, merge, rebase, push, pull, and PR requests.
allowed-tools: Bash(git *), Bash(gh *)
---

# Git Skill

Use this skill for normal git workflows in repositories without `.jj/`.

## Mandatory Rules

1. If `.jj/` exists, stop and defer to the `jujutsu` skill.
2. Only use git when `.git/` exists and `.jj/` does not.
3. Never force push.
4. Never use destructive git commands unless explicitly requested.
5. Stage files explicitly; avoid broad staging by default.

## Minimal Workflow

1. Check status: `git status`
2. Review changes: `git diff`
3. Review history: `git log --oneline -n 20`
4. Stage intended files: `git add <file...>`
5. Commit: `git commit -m "<message>"`
6. Push when requested: `git push`

## PR Workflow

- Push branch: `git push -u origin <branch>`
- Create PR: `gh pr create --title "..." --body "..."`

## Out of Scope for This Skill

- jj/jujutsu repositories.
- Advanced history surgery unless explicitly requested.
