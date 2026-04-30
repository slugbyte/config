## Output Style

- ASCII only in your prose. No decorative unicode and no emoji.
- Use `->`, `[x]`, `[ ]`, `-`, `--`, `"` instead.
- Preserve user text, code, logs, and filenames verbatim.

Examples of what to avoid (illustrative; not used elsewhere in the file):
arrows, check marks, bullets, em-dashes, smart quotes, box-drawing,
status emoji.

## Safety

- Ask before destructive operations that were not requested: `rm -rf`, force push, schema migrations, dropping data, package installs/upgrades, network-mutating calls.
- Never commit secrets, `.env` files, credentials, or API keys. If you find one in the working tree, stop and report.

## Engineering Style

**Priority order: safety > performance > developer experience.**

- Simple, explicit control flow.
- Avoid runtime recursion.
- Minimal abstractions.
- Bound any loop, queue, retry, or recursion that does not have a known input length. Loops over slices, arrays, args, or tool results are bounded by their input. Anything else (queues, retries, polling, producer/consumer, recursive walks) needs an explicit maximum.
- Assert what must be true and what must not be true.
- Split compound assertions into separate `assert` calls.
- Declare variables at the smallest scope, closest to their use.
- Always say why in comments. Always say how in test descriptions.
- Write comments as complete sentences: capitalize the first word, end with a full stop, put one space after `//`.
- Order in structs: fields, then types, then methods.
- Add units/qualifiers last by descending significance: `latency_ms_max`.
- Prefer the simplest return type that represents all real outcomes: `void` > `bool` > `T` > `?T` > `!T`. Do not hide recoverable errors in booleans or optionals.
- Show division intent: `@divExact`, `@divFloor`, or `divCeil`.
- Don't duplicate source-of-truth state. If you cache, denormalize, or precompute for performance (see Data-Oriented Design), document the owner and the invalidation rule.
- Pass options explicitly at call sites; don't rely on defaults.

For non-Zig code, follow project/ecosystem conventions and the project's configured formatter/linter; the engineering principles above still apply.

## Data-Oriented Design

- Design features for how computers work, not how humans categorize things.
- Define inputs, outputs, and transforms before writing code; let data layout drive architecture.
- Prefer contiguous homogeneous arrays over pointer-chasing.
- Separate hot data from cold.
- Use existence in an array to mean active -- no flags.
- Design for real data shapes, not hypothetical ones.
- Measure with a profiler; cache misses are invisible in source.

## Version Control

Always use the `vcs` skill for all VCS operations -- never invoke `jj` or `git` directly.

Use this format for both jj change descriptions and git commits:

    Short title under 50 chars

    - Bullet points with details
    - Markdown style body

## Project Root

- Use the `vroot` command (in `~/.local/bin`) whenever you need a project root path.
- It prints the nearest ancestor containing `.jj`, then `.git`, then the current directory as fallback.
- Prefer `vroot` over guessing path depth or assuming `cwd == project root`.

## Todo Tool

- Use the built-in `todo` tool for tasks with 3+ distinct steps or that span multiple files.
- Keep items short and concrete. Mark complete as soon as done.
- Use the todo tool whenever you are asked to discuss a group of issues one at a time.

## Workload Estimates

- Don't volunteer clock estimates (hours/days/weeks) -- agent-paced work compresses unpredictably.
- Give a rough scope ("~10 files", "small/medium/large") and flag risks or anything unusual (atomic swap, hidden coupling, open decisions).

## Agent Reviews

Reviews follow Output Style (ASCII only, no decorative unicode).

- Label every review item with a mnemonic code so it can be referenced quickly: severity `C`/`H`/`M`/`L` for Critical/High/Medium/Low, numbered within: `C1`, `C2`, `H1`. Don't invent opaque codes like `I12` or `E12`.
- Severity thresholds:
  - `C` = data loss, security, or task-blocking.
  - `H` = likely incorrect behavior or major maintainability risk.
  - `M` = unclear behavior, missing edge case, moderate risk.
  - `L` = polish, naming, minor consistency.
- Group review items into workflow buckets. Give each bucket a short label (`G1`, `G2`, ...) and a descriptive name (`Apply`, `Discuss`, `Blocked`). Define them at the top so items can be moved by reference, e.g. "move C2 to G2".

      G1 Apply: low risk, high consensus -> apply directly
      G2 Discuss: needs discussion -> walk through one at a time
      G3 Blocked: missing info -> ask user

  Example item: `M1: Clarify retry bounds. retry until success -> retry at most 3 times, then return error.Timeout`.

- Pick one primary grouping axis per review (usually workflow buckets). Other attributes like severity or source go inline on the item, not as separate sections.
- For multi-agent reviews, consolidate by action, not by reviewer. Don't partition sections by reviewer or prefix labels with reviewer names. Reassign subagent labels freely to keep the merged set simple. Attribution goes inline: `C1: auth race (flagged by buddy and claude)`. Merge duplicates, but preserve material disagreement inline.
- After producing a `review-*.md` file or presenting plan-review findings, STOP and wait for the user to request a fixup. Do not iterate review -> fixup -> review autonomously.

## Zig

### Style

Naming:

| kind                                          | casing                                  |
|-----------------------------------------------|-----------------------------------------|
| types, enum members, tagged-union variants    | PascalCase                              |
| functions                                     | camelCase                               |
| variables                                     | snake_case                              |
| constants                                     | SCREAMING_SNAKE_CASE                    |
| type files (one type per file, name matches)  | PascalCase, e.g. `Color.zig`            |
| namespace files (many exports, no owner)      | snake_case, e.g. `string_util.zig`      |

Other rules:

- Prefer descriptive names over abbreviations (`percent` not `pct`, `index` not `idx`, `calculateBoundingRect` not `calcBB`).
- Define explicit error sets, use `try` to propagate, reserve panics for unrecoverable states.
- Use `std.debug.assert` liberally to document and enforce invariants.
- Document public APIs with `///`. Comment focus is "why" -- see Engineering Style.
- Inline tests: `test "TEST: <description>" { ... }`. Alias `const t = std.testing;` and use `t.expect`, `t.expectEqual`, etc.
- Allocators: always passed as params. Name params `gpa` or `arena` when lifetime is clear, `allocator` when the caller decides.
- Use `zig fmt` for formatting.

### Reference

Zig stdlib browsable at `~/.local/share/mise/installs/zig/latest/lib/std` (read-only). Read it for reference; do not edit it.

## Plans

A plan is either:

- `plan/<slug>.md` -- simple plans, roadmaps, small patches, persistent context.
- `plan/<slug>/` -- feature directory with stage-tagged files inside.

Default flow: codereview -> research -> design -> guide -> review/fixup -> archive. Bug fixes start at `bug-`. Not every plan walks every stage; the lifecycle list is the canonical default.

Create a plan for: multi-session work, work that needs review/fixup cycles, anything risky enough that you want a paper trail.

Paths in this section (`./plan/`, `./archive/`) are relative to `vroot`.

### Plan stage lifecycle

1. codereview -- review existing code
2. research -- external resources
3. design -- goals, non-goals, architecture, contracts, edge cases
4. guide -- implementation guide for the design
5. review/fixup loop -- after each review, STOP and wait for the user to request a fixup. Do not iterate autonomously. (See Agent Reviews for the broader STOP rule.)
6. archive

### Stage vocabulary (feature directories)

Pattern: `<stage>-<descriptive-slug>.md`. Counters (`-NN-`) for ordering -- currently used in `fixup-NN-`. Apply elsewhere only if you produce more than one and order matters.

| stage                   | meaning                                                                                |
|-------------------------|----------------------------------------------------------------------------------------|
| `bug-<slug>.md`         | bug description that seeded the work                                                   |
| `codereview-<slug>.md`  | audit of existing code, before work starts                                             |
| `research-<slug>.md`    | external library / reference exploration                                               |
| `design-<slug>.md`      | goals, non-goals, architecture (no code)                                               |
| `guide.md`              | implementation guide for the design (can include code)                                 |
| `review-<slug>.md`      | review of something produced; slug says what (`review-post-impl`, `review-fixup-01`)   |
| `fixup-NN-<slug>.md`    | mini-guide resolving `review-` issues. User-triggered. `NN` per-feature, increments    |
| `index.md`              | agent-maintained TOC                                                                   |

Note: dates go inside files (`> created: YYYY-MM-DD`), not in filenames.

### Entering a feature directory

Read `index.md` first if it exists. If absent, read all matching files in lexicographic order within each stage; stages in the order:
`bug- -> codereview- -> research- -> design- -> guide -> review- -> fixup-NN-`.

Update `index.md` whenever you create, rename, archive, or materially change a plan file. One line per file with a short summary. Create it when first expanding a flat plan into a directory.

### Guide structure for complex features

Complex guides are split into phases, each containing steps. Use:

- `P<phase>` for a phase, with a short descriptive title (e.g. `P1: Prereqs`, `P2: Atomic swap`).
- `P<phase>.<step>` for steps inside a phase (e.g. `P2.3`). One level only -- no `P2.3.1`.

Split into a new phase wherever any of these apply (agent judgment, not a checklist):

- a natural commit point,
- a place that needs testing before continuing,
- enough work for a single focused coding session.

- No required internal structure -- write each phase however the work needs.
- Simple guides don't need phases.

### `plan` CLI

The `plan` CLI auto-creates `plan/`, `archive/`, and any subdirs as needed.

- Do not manually move files when the CLI can do it.
- `plan new <name>` -- create `plan/<name>.md` (flat plan).
- `plan new <slug> <name>` -- create `plan/<slug>/<name>.md` (file inside a feature directory).
- `plan expand <slug> <oldfile> [newfile]` -- move `plan/<oldfile>.md` into `plan/<slug>/`, optionally renaming.
- `plan archive <dirname> <path>...` -- move file(s) or dir(s) under `archive/<dirname>/`.

### Archive -- `./archive/`

- `archive/plan/`  -- archived plans
- `archive/bug/`   -- archived bug records (see `/bug` skill)
- `archive/recap/` -- session recaps (see `/recap` skill)
