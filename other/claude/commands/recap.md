---
description: Save a minimal recap of the current session
argument-hint: [session-name]
---
Create a minimal markdown recap of the current session and archive it with the `plan` CLI.

Workflow:
1. Run `vroot` (shell command in `~/bin`) to get the project root absolute path.
2. Determine the session name from: $ARGUMENTS
   - If provided, use it. Otherwise generate a short, specific kebab-case slug from the session goals/outcome.
   - Use a readable title in the document.
3. Write the recap content to a scratch path: `/tmp/<session-name>.md`.
4. Base content on the current conversation, tool usage, files touched, and any subagents used. Do not invent. If something was not used, say `None`.
5. Keep it concise — prefer bullets over prose. Do not dump the full transcript.
6. `cd` into the project root, then run `plan archive recap /tmp/<session-name>.md`. The CLI renames to `<date>-recap-<session-name>.md`, moves it into `./archive/recap/`, and injects the archive warning.

Use this structure in the scratch file:

```md
# Session Recap: <readable title>
> created: <yyyy-mm-dd>

> [!note]
> Brief recap of the session for later review.

## Goals
- ...

## Outcome
- Status: done / partial / blocked
- Result: ...

## Flow
1. ...
2. ...
3. ...

## Agent Usage
- Agent: Claude
- Strategy: ...
- Subagents or swarms used: ...
- Roles: ...

## Key Decisions
- ...

## Artifacts
- `path` — ...

## Next
- ...

## Takeaways
- ...
```

Output:
- Keep it brief.
- Show the archived path printed by `plan archive recap`.
- Mention whether the session name was provided or generated.
