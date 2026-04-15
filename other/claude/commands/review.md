---
description: Read-only review that creates discussion tasks
argument-hint: [target]
---
Deeply analyze and verify: $ARGUMENTS

If no target was provided, ask for it before continuing.

Rules:
- Read-only only.
- Do not modify the target, codebase, git state, or project state.
- Do not use Edit, Write, NotebookEdit, or shell commands that change state.
- Use Claude Code's read-only inspection tools plus its session task/todo list tools.
- Verify findings against the actual code. Do not guess.

Use the session task/todo list to create short discussion items for:
- confirmed bugs
- risky or unclear behavior
- worthwhile feature ideas

Task item style:
- short and specific
- discussion-oriented
- one topic per item

Output:
- Keep it brief.
- Say how many task items you created.
- Mention only major findings that did not fit well in a task item.
- If nothing stands out, say so briefly.
