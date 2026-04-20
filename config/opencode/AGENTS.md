## Todo Tool

- Use the built-in `todo` tool for tasks with 3+ distinct steps or that span multiple files.
- Keep items short and concrete. Mark complete as soon as done.

## Zig Standard Library

Browsable at `~/.local/share/mise/installs/zig/latest/lib/std` (read-only).

## Zig Code Style

- Prefer descriptive names over abbreviations (`percent` not `pct`, `index` not `idx`, `calculateBoundingRect` not `calcBB`)
- Naming: PascalCase for types, enum members, and tagged-union variants. camelCase for functions. snake_case for variables. SCREAMING_SNAKE_CASE for constants.
- Files: type files (one type per file, filename matches type) are PascalCase like `Color.zig`. Namespace files (many exports, no single owning type) are snake_case like `string_util.zig`.
- Define explicit error sets, use `try` to propagate, reserve panics for unrecoverable states
- Use `std.debug.assert` liberally to document and enforce invariants
- Document public APIs with `///`, keep comments focused on "why"
- Inline tests: `test "TEST: <description>" { ... }`
- In tests, alias the testing namespace with `const t = std.testing;` and use `t` for all assertions (e.g., `t.expect(...)`, `t.expectEqual(...)`)
- Allocators: Always passed as params. Name params `gpa` or `arena` when lifetime is clear, `allocator` when the caller decides.
- Use `zig fmt` for formatting

## Version Control

Always use the `vcs` skill for all VCS operations -- never invoke `jj` or `git` directly.

### Commit messages and change descriptions

Format:

    Short title under 50 chars

    - Bullet points with details
    - Markdown style body

## Engineering Style

Safety first, then performance, then developer experience.

- Simple, explicit control flow. Avoid runtime recursion. Minimal abstractions.
- Put a limit on everything -- all loops and queues need a fixed upper bound.
- Assert what must be true and what must not be true. Split compound assertions.
- Declare variables at the smallest scope, closest to their use.
- Always say why in comments, always say how in test descriptions.
- Comments are sentences: capital letter, full stop, space after `//`.
- Order in structs: fields, then types, then methods.
- Add units/qualifiers last by descending significance: `latency_ms_max`.
- Prefer simpler return types: `void` > `bool` > `T` > `?T` > `!T`.
- Show division intent: `@divExact`, `@divFloor`, or `divCeil`.
- Don't duplicate state. Compute values close to where they are used.
- Pass options explicitly at call sites, don't rely on defaults.

## Data-Oriented Design

Design features for how computers work, not how humans categorize things.
Define inputs, outputs, and transforms before writing code and let data
layout drive the architecture. Prefer contiguous homogeneous arrays over
pointer-chasing. Separate hot data from cold, and use existence in an array
to mean active -- no flags. Design for real data shapes, not hypothetical
ones. Measure with a profiler; cache misses are invisible in source.

## Agent Reviews (single-agent and multi-agent consolidation)

- ASCII only in your review prose. No decorative unicode (→ ✓ ✗ •, em-dashes, smart quotes, box-drawing) and no emoji (✅ ❌ ⚠️ 🔴 🟡 🟢). Use `->`, `[x]`, `[ ]`, `-`, `--`, `"`. Preserve user text, code, logs, and filenames verbatim.
- Label every review item with a mnemonic code so it can be referenced quickly: severity `C`/`H`/`M`/`L` for Critical/High/Medium/Low, numbered within: `C1`, `C2`, `H1`. Don't invent opaque codes like `I12` or `E12`.
- Group review items into workflow buckets. Give each bucket a short label (`G1`, `G2`, ...) and a descriptive name (`Apply`, `Discuss`, `Blocked`). Define them at the top so items can be moved by reference, e.g. "move C2 to G2":

      G1 Apply: low risk, high consensus -> apply directly
      G2 Discuss: needs discussion -> walk through one at a time
      G3 Blocked: missing info -> ask user

- Pick one primary grouping axis per review (usually workflow buckets). Other attributes like severity or source go inline on the item, not as separate sections.
- For multi-agent reviews, consolidate by action, not by reviewer. Don't partition sections by reviewer or prefix labels with reviewer names. Reassign subagent labels freely to keep the merged set simple. Attribution goes inline: `C1: auth race (flagged by buddy and claude)`. Merge duplicates, but preserve material disagreement inline.

## Workload Estimates

- Don't volunteer clock estimates (hours/days/weeks) -- agent-paced work compresses unpredictably.
- Give a rough scope ("~10 files", "small/medium/large") and flag risks or anything unusual (atomic swap, hidden coupling, open decisions).

## Plans

### Active plans -- `./plan/`

A plan is either:
- `plan/<slug>.md` -- simple plans, roadmaps, small patches, persistent context
- `plan/<slug>/` -- feature directory with stage-tagged files inside

#### Plan Stage lifecycle
1. codereview - review existing code
2. research - external resources
3. design - goals, non-goals, architecture, contracts, edge cases
4. guide - implementation guide for the design
5. review/fixup loop -- after each review, STOP and wait for user to request a fixup. Do not iterate autonomously.
6. archive

#### Stage vocabulary (feature directories)

Pattern: `<stage>-<descriptive-slug>.md`. Counters (`-NN-`) for ordering.

| stage | meaning |
|-------|---------|
| `bug-<slug>.md`         | bug description that seeded the work |
| `codereview-<slug>.md`  | audit of existing code, before work starts |
| `research-<slug>.md`    | external library / reference exploration |
| `design-<slug>.md`      | goals, non-goals, architecture (no code) |
| `guide.md`              | implementation guide for the design (can include code) |
| `review-<slug>.md`      | review of something produced; slug says what (`review-post-impl`, `review-fixup-01`) |
| `fixup-NN-<slug>.md`    | mini-guide resolving `review-` issues. User-triggered. `NN` per-feature, increments by fixup request |
| `index.md`              | agent-maintained TOC |

Dates go inside files (`> created: <date>`), not in filenames.

#### Entering a feature directory

Read `index.md` first if it exists. If absent, read in this order:
`bug- -> codereview- -> research- -> design- -> guide -> review- -> fixup-NN-`.

Maintain `index.md` as you work -- one line per file with a short summary. Create it when first expanding a flat plan into a dir.

#### Guide structure for complex features

Complex guides are split into phases, each containing steps. Use:

- `P<phase>` for a phase, with a short descriptive title (e.g. `P1: Prereqs`, `P2: Atomic swap`).
- `P<phase>.<step>` for steps inside a phase (e.g. `P2.3`). One level only -- no `P2.3.1`.

Split into a new phase wherever any of these apply (agent judgment, not a checklist):
- a natural commit point,
- a place that needs testing before continuing,
- enough work for a single focused coding session.

No required internal structure -- write each phase however the work needs. Simple guides don't need phases.

### `plan` CLI

Auto-creates `plan/` and `archive/` and any subdirs as needed. Do not manually move files when the CLI can do it.

- `plan new <filename>` -- create `plan/<filename>.md`
- `plan new <slug> <filename>` -- create `plan/<slug>/<filename>.md`
- `plan expand <slug> <oldfile> [newfile]` -- move `plan/<oldfile>.md` into `plan/<slug>/`
- `plan archive <dirname> <path>...` -- move file(s) or dir(s) under `archive/<dirname>/`

### Archive -- `./archive/`

- `archive/plan/`  -- archived plans
- `archive/bug/`   -- archived bug records (see `/bug` skill)
- `archive/recap/` -- session recaps (see `/recap` skill)
