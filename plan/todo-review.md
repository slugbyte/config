# Todo Review
> created: 2026-04-15

## Goal

Document the verified issues found during review of `other/pi/extensions/todo.ts`
and outline safe implementation approaches without changing the extension yet.

## Findings

- The extension stores todo state in tool-result `details`, which matches pi's
  documented branching pattern.
- The current implementation mixes shallow array snapshots with in-place object
  mutation, which breaks snapshot isolation in memory.
- The widget and `/todo view` UX are useful, but some behaviors are implicit and
  likely surprising when the list changes during a session.

## Confirmed bugs

### 1. In-memory history snapshots can be rewritten by later toggles

Evidence:

- `add`, `list`, and `toggle` store `todos: [...todos]` in result details
  (`other/pi/extensions/todo.ts:285,293,302,314,323,334,358`).
- Those are shallow copies of the array, not deep copies of each `Todo` object.
- `toggle` mutates the matched todo in place with `todo.done = !todo.done`
  (`other/pi/extensions/todo.ts:329`).
- The extension then reuses `details.todos` directly on reconstruction and on
  `tool_result` (`other/pi/extensions/todo.ts:60,251`).
- pi keeps session entries in memory by reference via `appendMessage()` and
  returns the same branch objects from `getBranch()`
  (`dist/core/session-manager.js:576,751`).

Impact:

- While the session is still running, a later toggle can mutate todo objects
  that were already captured in earlier tool-result entries.
- `/tree` reconstruction can therefore show the wrong historical todo state
  until the session is reloaded from disk.

Suggested implementation:

- Add a `cloneTodos()` helper that deep-copies each todo object.
- Use it whenever writing `details.todos`.
- Also use immutable updates for toggle, e.g. rebuild the array with a copied
  toggled item instead of mutating `todo.done` in place.
- When loading from `details.todos`, clone again before assigning to in-memory
  state so future mutations cannot alias persisted snapshots.

## Risks and unclear behavior

### 1. `reconstructTodos()` trusts `details` without runtime validation

Evidence:

- `reconstructTodos()` casts `message.details` to `TodoDetails | undefined` and
  assigns `details.todos` / `details.nextId` directly
  (`other/pi/extensions/todo.ts:57-61`).
- The `tool_result` event handler does the same with `event.details`
  (`other/pi/extensions/todo.ts:249-252`).

Risk:

- Malformed or partially incompatible session data can corrupt extension state or
  crash rendering paths.
- This matters most if the file format evolves or if older session entries exist.

Suggested implementation:

- Add a small runtime guard such as `isTodoDetails(value): value is TodoDetails`.
- Validate `action`, `nextId`, and each todo object before accepting the state.
- If validation fails, ignore that entry and keep the last known-good state.

### 2. `list` persists a full state snapshot on every read-only call

Evidence:

- `list` returns full `details: { action: "list", todos: [...todos], nextId }`
  (`other/pi/extensions/todo.ts:285`).
- pi stores tool-result details in session history for reconstruction.

Risk:

- Frequent `todo.list` calls duplicate the entire todo array in session history
  even though they do not change state.
- Large todo lists or repeated planning loops can inflate session size for no
  behavioral benefit.

Suggested implementation:

- Make `reconstructTodos()` accept optional snapshots instead of assuming every
  action carries one.
- Stop storing full snapshots for `list`, or store only lightweight metadata for
  rendering while leaving state reconstruction to the last mutating action.
- Keep full snapshots for `add`, `toggle`, and `clear`.

### 3. `/todo view` is a snapshot, not a live view

Evidence:

- `/todo view` constructs `new TodoListComponent(todos, theme, ...)` using the
  current array at command time (`other/pi/extensions/todo.ts:470`).
- `TodoListComponent` owns its own `todos` field and has no subscription back
  to the shared extension state.

Risk:

- If todos change while the overlay is open, the modal will keep showing the old
  list until it is closed and reopened.
- This may be acceptable, but the behavior is currently implicit.

Suggested implementation:

- Either document `/todo view` as a snapshot view,
- or make the component read from shared state and invalidate on todo updates so
  it behaves like a live view.

## Worthwhile feature ideas

### 1. Keep todo ids monotonic after `clear`

Evidence:

- `clear` resets `nextId = 1` (`other/pi/extensions/todo.ts:346`).

Why it may help:

- Reusing ids after clear can make historical references harder to reason about
  in transcripts and branch discussions.

Suggested implementation:

- Preserve `nextId` across `clear` so ids remain unique within a session branch.
- If compact ids are preferred, keep the current behavior and document it.

### 2. Add `remove` and `edit` actions

Why it may help:

- The current API only supports `add`, `toggle`, `clear`, and `list`.
- Users cannot correct wording or remove stale tasks without clearing the whole
  list.

Suggested implementation:

- Add `remove(id)` and `edit(id, text)` actions.
- Reuse the same snapshot persistence strategy as the existing mutating actions.
- Update `renderCall`, `renderResult`, and `/todo` help text accordingly.

## Implementation outline

1. Introduce a `cloneTodos()` helper and a runtime `isTodoDetails()` guard.
2. Convert toggle to immutable updates and eliminate all in-place mutation.
3. Ensure reconstruction and `tool_result` handling always clone validated data.
4. Reduce `list` persistence so read-only calls do not store redundant snapshots.
5. Decide whether `/todo view` should stay snapshot-based or become live.
6. Optionally add monotonic ids, `remove`, and `edit` as separate follow-up work.

## Verification

- Reproduce the aliasing bug in one live session:
  1. add a todo
  2. inspect the earlier tool-result state via `/tree`
  3. toggle the todo
  4. confirm the earlier entry now reflects the toggled state in memory
- Restart pi and confirm the same historical entry reloads correctly from disk.
- Confirm malformed `details` entries are ignored rather than crashing state
  reconstruction.
- Confirm repeated `todo.list` calls no longer grow stored snapshots.
- If `/todo view` becomes live, change todos while the overlay is open and
  confirm the list updates correctly.
