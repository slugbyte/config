---
description: "Create a jj change description based on current working copy changes."
model: openai/gpt-5.2-codex
---
Create a jj change description based on current working copy changes.

- Step 1: get a diff of the working copy changes to summerize
  * `jj diff` - view all the actual changes to modified files
- Step 2: create a consice summery description of the current changes with the following style
  * the first line should be less than 50 chars and describe **WHAT** change has happend
  * the following lines should be a concise but comprehensive markdown explination of the changes made
  * the description should focus on the why more than the what
  * if no changes have been made just stay so and dont continue and dont prompt the user
- Step 3: run `jj desc -m <your summary>` with the summary you have created
  * dont ask permision just run it
