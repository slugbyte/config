## Communication

- If you have unresolved questions or ambiguities about a task, ask before proceeding.

## Zig Standard Library

The Zig standard library is installed via mise at:

    ~/.local/share/mise/installs/zig/<version>/lib/std

The current latest version is at:

    ~/.local/share/mise/installs/zig/latest/lib/std

You have read access to the entire `~/.local/share/mise/installs/zig/` tree.
When the user is working with Zig, you can reference the standard library source
directly to answer questions or understand behavior.

## Notes

When asked to save or write a note, write it as a markdown file in the
`./note/` directory using Obsidian-style markdown.

### Filename

Use a date-prefixed filename:

    note/yyyy-mm-dd-note-name.md

For example: `note/2026-02-20-architecture-overview.md`

### Format

- Start with a top-level heading as the title
- Immediately below the title, include the date and model name in italics,
  for example: *2026-02-20 -- claude-sonnet-4-5*
- Use [[wikilinks]] to link to other notes instead of standard markdown links
- Use #tags inline to categorize content (e.g., #zig, #architecture, #debugging)
- Use Obsidian callout blocks where appropriate (e.g., `> [!note]`, `> [!warning]`)
- Write notes in your own words as clear explanations -- not copy-pasted code dumps

## Zig Code Style

- Prefer descriptive names over abbreviations (`percent` not `pct`, `index` not `idx`, `calculateBoundingRect` not `calcBB`)
- PascalCase for types and type files, camelCase for functions, snake_case for variables, SCREAMING_SNAKE_CASE for constants
- Define explicit error sets, use `try` to propagate, reserve panics for unrecoverable states
- Use `std.debug.assert` liberally to document and enforce invariants
- Document public APIs with `///`, keep comments focused on "why"
- Inline tests: `test "TEST: <description>" { ... }`
- In tests, alias the testing namespace with `const t = std.testing;` and use `t` for all assertions (e.g., `t.expect(...)`, `t.expectEqual(...)`)
- Allocators: Always passed as params. Name params `gpa` or `arena` when lifetime is clear, `allocator` when the caller decides.
- Use `zig fmt` for formatting

## Version Control Messages

For both `jj desc` and `git commit`, use:

    Short title under 50 chars

    - Bullet points with details
    - Markdown style body
