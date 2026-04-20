---
name: explore-opensource-library-impl
description: >
  Prompt template for exploring open-source code (extracted from paint/note).
  User will refine later.
---


```
I'm learning how this library works from the ground up. Analyze the codebase and explain the following to me in clear, educational terms. Assume I'm a systems programmer comfortable with C and graphics but unfamiliar with this specific codebase.

## Architecture

- What are the main public API functions and what does each do?
- Trace a simple input through the full pipeline from entry point to output.
- What are the core data structures and how do they relate?

## Memory

- How is memory allocated? Can I supply my own allocator?
- Where do allocations happen and what are their lifetimes?

## Algorithm

- What algorithm is implemented and where does each phase begin in the code?
- How are degenerate/edge cases handled (coincident points, zero-area, self-intersections)?

## Integration

- What's the minimal code to use this library for a basic case?
- What format does input/output use (flat arrays, structs, index buffers)?
- What compile-time defines or configuration options exist?
- What hard limitations should I know about?

## Portability

- Any libc dependencies, global state, or platform-specific assumptions?
- How would I build this as a static C library from a Zig build system?
```

# follow up prompts


```
I'm learning how this library works from the ground up. Analyze the codebase and explain the following to me in clear, educational terms. Assume I'm a systems programmer comfortable with C and graphics but unfamiliar with this specific codebase.

can you create a detailed note of the public api and example usage called api-overview
```

```
can you create a note that is a explianer about how the earcut algo works without any code called how-it-works
```

```
can you create a note with a consise overview that covers what it is, key capabilities, limitations, dependencies, resouces links (like git remote, website, docs), and a break down of the lines of code for the different interal features of the codebase called overview
```
