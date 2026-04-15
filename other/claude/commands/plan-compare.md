---
description: Read-only comparison of multiple plan files that creates discussion tasks
argument-hint: [plan-file ...]
---
Read and compare these plan files: $ARGUMENTS

If fewer than two plan files were provided, ask for the missing paths before continuing.

Rules:
- Read-only only.
- Do not modify plans, code, git state, or project state.
- Do not use Edit, Write, NotebookEdit, or shell commands that change state.
- Use Claude Code's read-only inspection tools plus its session task/todo list tools.
- Verify comparisons against the actual plan files and any relevant code or docs. Do not guess.

Compare for:
- scope and goals
- sequencing and dependencies
- risks, gaps, and contradictions
- overlap, duplication, or merge opportunities
- worthwhile ideas missing from one plan but covered by another

Use the session task/todo list to create short discussion items for:
- conflicts between plans
- missing or weak plan details
- merge or simplification opportunities
- useful follow-up questions or ideas

Task item style:
- short and specific
- discussion-oriented
- one topic per item

Output:
- Keep it brief.
- Say how many task items you created.
- Briefly summarize the biggest differences or conflicts.
- If the plans are aligned, say so briefly.
