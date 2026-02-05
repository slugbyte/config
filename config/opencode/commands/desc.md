---
description: "Create a jj change description based on current working copy changes."
---
Create a jj change description based on current working copy changes.

- Step 1: Use the following commands to gather a comprehensive understanding of what changes have been made to this repository.
  * `jj status` - see what files have been modified
  * `jj diff` - view all the actual changes to modified files
  * `jj log -n 5` - view recenst history
- Step 2: create a consice summery description of the current changes with the following style
  * the first line should be less than 50 chars and describe **WHAT** change has happend
  * the following lines should be a concise but comprehensive markdown explination of the changes made
  * if the notes folder explains why the changes were made you short include a short description of why these changes were made.
  * if no changes have been made just stay so and dont continue and dont prompt the user
- Step 3: run `jj desc -m <your summary>` with the summary you have created
  * dont ask permision just run it
