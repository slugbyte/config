---
description: Read-only verification of a plan against its implementation
---
Read the plan file: $1

Verify whether the implementation in the codebase matches the plan.

Rules:
- Read-only only.
- Do not modify the plan, codebase, or project state.
- Verify claims against the actual code, tests, docs, and config. Do not guess.

Check for:
- planned work that is missing or incomplete
- implementation that differs from the plan
- missing tests or validation
- follow-up work or cleanup implied by the plan

Use the todo tool to create short discussion items for:
- plan items not implemented
- mismatches between the plan and implementation
- missing validation or follow-up work

Todo style:
- short and specific
- discussion-oriented
- one topic per todo

Output:
- Keep it brief.
- Say how many todos you created.
- Briefly summarize overall plan coverage.
- If the implementation matches well, say so briefly.
