---
name: explore-opensource-application-impl
description: >
  Prompt template for exploring open-source code (extracted from paint/note).
  User will refine later.
---

```
I'm studying this application to understand how it's built and learn from its design decisions. Explain the following to me in clear, educational terms. Assume I'm a systems programmer comfortable with C and low-level graphics but unfamiliar with this specific codebase.

## High-Level Architecture

- What does this application do and what problem does it solve?
- What are the major subsystems/modules and how do they communicate?
- Draw me an ASCII diagram of the overall architecture.

## Build & Dependencies

- What are the external dependencies and what role does each play?
- How is the build system structured? What are the build targets?
- What platforms are supported and how is portability handled?

## Core Loop

- What does the main loop look like? Walk me through one frame/cycle.
- How is state managed across the application?
- How does it handle input, and how does input flow into the rest of the system?

## Rendering / Output

- How does it get pixels on screen? What graphics API or abstraction does it use?
- How is drawing organized (immediate mode, retained, scene graph, command buffer)?
- Where are the hot paths and what performance considerations are visible in the code?

## Data Model

- What are the core data structures that represent the user's work/content?
- How is data serialized for saving/loading? What file format is used?
- How is undo/redo implemented, if at all?

## UI

- How is the UI built? Custom, immediate-mode, toolkit?
- How are layout and event handling structured?
- How does the UI layer interact with the core data model?

## Design Patterns & Takeaways

- What are the most interesting or unusual design decisions in this codebase?
- What patterns here could I reuse in my own projects?
- Where are the rough edges or known limitations?
```


  
  