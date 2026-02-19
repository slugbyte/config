---
description: "Export a concise session recap"
model: openai/gpt-5.2-codex
---

Create a concise markdown recap of this OpenCode session about "$NAME" and save it to `$root/note/export/yyyy-mm-dd-$NAME.md`.

Before writing, ensure the directory exists: `$root/note/export`.

The recap must include exactly these sections:

## Problem
Summarize the problem or goal addressed in this session.

## Decisions
List the key decisions made and why they were chosen.

## Changes Overview
Provide a concise overview of the changes made (files touched and what changed at a high level).

Be brief, clear, and focused on those three sections. Save the final content to the path above.
