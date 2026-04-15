---
description: Read-only verification of a plan against its implementation
argument-hint: [plan-file]
---
Read the plan file: $ARGUMENTS

If no plan file path was provided, ask for it before continuing.

Verify whether the implementation in the codebase matches the plan.

Rules:
- Read-only only.
- Do not modify the plan, codebase, git state, or project state.
- Do not use Edit, Write, NotebookEdit, or shell commands that change state.
- Use Claude Code's read-only inspection tools plus its session task/todo list tools.
- Verify claims against the actual code, tests, docs, and config. Do not guess.

Check for:
- planned work that is missing or incomplete
- implementation that differs from the plan
- missing tests or validation
- follow-up work or cleanup implied by the plan

Use the session task/todo list to create short discussion items for:
- plan items not implemented
- mismatches between the plan and implementation
- missing validation or follow-up work

Task item style:
- short and specific
- discussion-oriented
- one topic per item

Output:
- Keep it brief.
- Say how many task items you created.
- Briefly summarize overall plan coverage.
- If the implementation matches well, say so briefly.
