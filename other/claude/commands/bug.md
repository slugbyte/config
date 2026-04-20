---
description: Create or update a bug-fix record under plan/bug/
argument-hint: [bug-name]
---
Create (or update) a markdown bug record at `plan/bug/<slug>.md`. Captures symptom, root cause, patch, and debugging path. Pre-fix records are allowed — patch and verification fields can be `TBD`. Archive with `plan archive bug plan/bug/<slug>.md` once the fix is complete.

Workflow:
1. Run `vroot` (shell command in `~/bin`) to get the project root absolute path.
2. Determine the bug name from: $ARGUMENTS
   - If provided, use it. Otherwise generate a short, specific kebab-case slug from the bug.
   - Use a readable title in the document.
3. If `plan/bug/<slug>.md` does not exist: create it with `plan new bug <slug>` (run from anywhere inside the repo). If it already exists: read it and update the sections in place rather than overwriting.
4. Determine jj change IDs and git commit IDs for the fix, if any.
   - Run `jj log -r @- --no-graph -T 'change_id ++ " " ++ commit_id ++ "\n"'` to pre-fill from the most recent change.
   - For multiple changes, list them all. If uncommitted or unfixed, write `TBD` or `None — uncommitted`.
5. Fill the template based on the current conversation and tool usage. Do not invent. Distinguish **symptom** (observed) from **root cause** (actually broken). Prefer bullets.

Template:

```md
# Bug Fix: <readable title>
> created: <yyyy-mm-dd>

## Bug
- Symptom: ...
- Reproduction: ...
- Impact: ...
- Root cause: ...

## Patch
- Change IDs: <jj change id>, ...    (or `TBD` / `None — uncommitted`)
- Commit IDs: <git commit id>, ...   (or `TBD` / `None`)
- Change: 1-3 sentences on what the fix does and why. (`TBD` if not yet fixed.)

## Debugging
- Path from symptom to root cause (bullets).
- Tools used: debugger, logs, agents, grep, etc.
- Failed hypotheses (brief, if relevant): ...

## Verification
- How we confirmed the fix: ...    (or `TBD`.)
```

Output:
- Keep it brief.
- Show the bug file path (`plan/bug/<slug>.md`).
- Mention whether the name was provided or generated, and whether the record was created or updated.
