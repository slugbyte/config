---
description: Commit current work using the vcs skill
argument-hint: [message]
---
Use the `vcs` skill and follow its mandatory rules.

Goal: commit the current worktree.

Workflow:
1. Run `vstate` first.
2. Review the current changes before committing.
3. Determine the commit message from: $ARGUMENTS
   - If a message was provided, use it unless it needs light cleanup to match project conventions.
   - If no message was provided, write one from the changes.
   - Follow this format:
     - short title under 50 chars
     - blank line
     - markdown bullet list body
4. Commit with `vcommit` using the final message as a single argument.
5. Do not push.
6. If there is nothing to commit, say so briefly and stop.

Output:
- Keep it brief.
- Show the final commit message.
- Summarize what was committed.
