---
name: buddy-review
description: REQUIRED when the user explicitly says "buddy", "task-buddy", or "verify-buddy" (or plurals "buddies", "task-buddies", "verify-buddies", and close variants like "use buddy", "run a task-buddy", "do a verify-buddy", "run 4 verify-buddies"). Do not trigger on generic phrases like "second opinion", "external review", "another model", or "GPT" -- only on the literal terms buddy / task-buddy / verify-buddy (and their plurals).
allowed-tools: Bash(buddy *), Bash(vdiff *), Agent, Read
---

# Buddy Review

`buddy` is a read-only wrapper around `pi -p` running an external
model. Use it for second opinions, never as the primary author.

## Mode selection

The user's word picks the mode. Do not switch modes on your own.

| User says      | Mode               | What it means                                                                                  |
|----------------|--------------------|------------------------------------------------------------------------------------------------|
| "buddy"        | Direct             | Claude runs buddy itself.                                                                      |
| "task-buddy"   | task-buddy         | Subagent passes the request to buddy and returns a double-checked report.                      |
| "verify-buddy" | verify-buddy       | Subagent does the work, has buddy double-check, and returns the report.                        |

## Rules (every mode)

- No secrets, credentials, `.env`, customer data, or production logs.
- Narrow paths only. `@path` is a pi context ref, not a glob -- no
  directory expansion. Avoid vendored dirs and large diffs; split into
  focused calls.
- Advisory only. Verify file paths, symbols, and line ranges against
  the source before promoting any finding -- buddy hallucinates refs.
- No session. Every call is self-contained; put all context in one
  prompt.
- Buddy tools are `read,grep,find,ls` only. It cannot run tests, VCS,
  or builds.
- Subagents: no edits, no commits, no installs.

## Invocation

    buddy @path/to/file.ts "focused review prompt"
    buddy @a.ts @b.ts "prompt"
    vdiff | buddy "review this diff"
    buddy @file.ts <<'PROMPT'
    multiline prompt
    PROMPT

Stdin and args both feed pi -- pick one cleanly, do not rely on merge
order.

## Goals per mode

Buddy hallucinates refs, so double-checking is part of the goal in
every mode. For task-buddy and verify-buddy, the spawned subagent
does not see this skill or your conversation -- hand over goals and
the user's request, not steps.

### buddy (direct)

- Pass the user's request with relevant context to buddy.
- Double-check buddy's report against the source.
- Respond with the double-checked report.

### task-buddy

Goals for the subagent:
- Pass the user's request with relevant context to buddy.
- Double-check buddy's report against the source.
- Return the double-checked report.

Example, given user said "task-buddy review plan/<feature>/guide.md
for implementation readiness":

    The user asked: "review plan/<feature>/guide.md for
    implementation readiness -- unanswered questions, design bugs,
    anything needing further planning."

    Run buddy with the relevant context, double-check buddy's
    report against the guide, and return the double-checked report.
    Do not edit, commit, or install.

### verify-buddy

Goals for the subagent:
- Do the user's request.
- Ask buddy to double-check your findings.
- Return the double-checked report.

Example, given user said "verify-buddy review plan/<feature>/guide.md
for implementation readiness":

    The user asked: "review plan/<feature>/guide.md for
    implementation readiness -- unanswered questions, design bugs,
    anything needing further planning."

    Do the work, ask buddy to double-check your findings, and
    return the double-checked report. Do not edit, commit, or
    install.

## Reporting

Report what is useful for the task -- format is yours to choose. Call
out where you disagree with buddy.
