---
description: Update the current change description using the vcs skill
argument-hint: [message]
---
Use the `vcs` skill and follow its mandatory rules.

Goal: update the current change description without advancing history.

Workflow:
1. Run `vstate` first.
2. Review the current change before updating its description.
3. Determine the description message from: $ARGUMENTS
   - If a message was provided, use it unless it needs light cleanup to match project conventions.
   - If no message was provided, write one from the changes.
   - Follow this format:
     - short title under 50 chars
     - blank line
     - markdown bullet list body
4. Update the description with `vdesc` using the final message as a single argument.
5. Do not create a new change and do not push.
6. If there is nothing meaningful to describe, say so briefly and stop.

Output:
- Keep it brief.
- Show the final description message.
- Summarize what changed.
