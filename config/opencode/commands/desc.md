---
description: "Create a jj change description based on current working copy changes."
model: openai/gpt-5.2-codex
---
Create a jj change description based on current working copy changes.

## Step 1: Get the diff
Run `jj diff` to view all working copy changes.

If there are no changes, say so and stop. Don't prompt the user or continue.

## Step 2: Write the description
Write a concise summary of the changes with this format:

- **First line**: less than 50 chars, describes **what** changed (e.g. "add fish shell config", "fix tmux keybind conflict")
- **Body**: a concise but comprehensive markdown explanation focused on **why** the changes were made, not just what they are

## Step 3: Apply the description
Run `jj desc -m <your description>` to set the description. Don't ask for permission, just run it.
