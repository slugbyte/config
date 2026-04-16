---
description: Save a minimal recap of the current session
argument-hint: [session-name]
---
Create a minimal markdown recap of the current session and save it under the project root.

Workflow:
1. Determine the project root with `vroot`.
   - Run `vroot` and use the returned path as the project root.
   - If `vroot` fails unexpectedly, ask before writing.
2. Create `./recap` under the project root if it does not exist.
3. Determine the session name from: $ARGUMENTS
   - If a name was provided, use it.
   - If no name was provided, generate a short, specific name from the session goals and outcome.
   - Use a kebab-case slug for the filename.
   - Use a readable title in the document.
4. Use today's date in `yyyy-mm-dd` format for the filename and the `> created:` line.
5. Write the recap to `./recap/<yyyy-mm-dd>-<session-name>.md`.
   - Do not overwrite an existing recap.
   - If the filename already exists, append `-2`, `-3`, and so on.
6. Base the recap on the current conversation, tool usage, files touched, and any subagents or swarms used.
   - Do not invent details.
   - If something was not used, say `None`.
7. Keep the recap concise and easy to skim.
   - Prefer bullets over prose.
   - Do not dump the full transcript.

Use this structure:

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
- Show the saved file path.
- Mention whether the session name was provided or generated.
