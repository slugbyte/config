---
name: plan
description: Create, refine, review, merge, and archive project plan files. Use when the task is about planning work, naming plan files, creating new plan documents under ./plan, or archiving completed plans into ./plan-archive.
---

# Plan Skill

Use this skill whenever the user asks to:

- create a new plan file
- refine or review an existing plan
- merge multiple plans into one
- archive completed plan files
- follow a project's plan-file conventions

## Core Rules

1. Plan files live in `./plan`.
2. New plan files should be created with the `plan new` CLI.
3. Archived plan files should be moved with the `plan archive` CLI.
4. Do not manually move archived plan files when the CLI can do it.
5. Preserve project-specific plan conventions from `AGENTS.md`.

## Naming

Plan files use this format:

```text
./plan/feature-name.md
```

The creation date is stored inside the file, not in the filename.

Examples:

- `./plan/ui-animation.md`
- `./plan/render-cache.md`

## Creating New Plans

Use:

```bash
plan new feature-name
```

This creates a markdown file in `./plan` with the creation date inside:

```md
# Feature Name
> created: yyyy-mm-dd
```

If the user wants multiple plans:

```bash
plan new feature-a feature-b
```

## Archiving Plans

Use:

```bash
plan archive ./plan/feature-name.md
```

The CLI:

- moves the file to `./plan-archive`
- prepends the archive date to the filename (e.g., `plan-archive/yyyy-mm-dd-feature-name.md`)
- creates `./plan-archive` if needed
- adds the archive warning note
- keeps both files on name collision by adding a numeric suffix

## Archive Warning Block

Archived plan files should include this block near the top:

```md
> [!warning] Archived
> This plan has been archived and is kept for reference only. It does not
> reflect active work.
```

## Plan Review and Merge Guidance

When reviewing or merging plans:

- keep the final plan focused on implementation intent
- remove duplicated steps
- defer optional ideas into a later phase when appropriate
- clearly separate goals, non-goals, phases, risks, and verification
- prefer one unified plan file over multiple overlapping drafts

## Workflow Guidance

A good default workflow is:

1. Review existing plan files in `./plan`.
2. Create a new plan with `plan new` if needed.
3. Refine the plan content with the user before implementation.
4. Archive superseded or completed plan files with `plan archive`.

## Notes

- The project root is the directory that contains the `plan/` folder.
- `plan archive` accepts multiple files, but they must belong to the same project root.
- `plan new` prints created paths, and `plan archive` prints source/destination mappings.
