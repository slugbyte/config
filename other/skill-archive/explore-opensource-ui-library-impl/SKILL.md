---
name: explore-opensource-ui-library-impl
description: >
  Prompt template for exploring open-source code (extracted from paint/note).
  User will refine later.
---

```
I'm studying this UI library to understand its design and internals so I can learn from it and apply ideas to my own immediate-mode GUI implementation. Explain the following to me in clear, educational terms. Assume I'm a systems programmer building my own UI system on top of my own custom OpenGL render.

## Paradigm & Philosophy

- Is this immediate-mode, retained-mode, or a hybrid? How does it manage widget state?
- What is the core abstraction? (widgets, views, nodes, commands?)
- What tradeoffs has this library chosen and what has it explicitly sacrificed?

## Layout

- How does the layout system work? (constraint-based, flexbox-like, semantic sizing, manual?)
- How are sizes resolved — single pass or multi-pass?
- How are parent-child size relationships handled (shrink-to-fit, fill, fixed)?
- How does it handle overflow, scrolling, and clipping?

## Widget Tree & State

- How is the widget hierarchy represented in memory?
- How is per-widget state stored and looked up between frames (hash, index, pointer)?
- How are IDs generated and what happens on collisions?
- How does it handle dynamic widget counts (lists, conditional elements)?

## Input & Interaction

- How does input flow from OS events to individual widgets?
- How is focus, hover, and active state tracked?
- How does hit testing work? Bounding box, hierarchy walk, spatial index?
- How are drag, scroll, and multi-touch interactions handled?

## Rendering

- How does it emit draw commands? (vertex buffers, command lists, callbacks?)
- How is draw order and layering managed (z-index, painter's algorithm, sorted)?
- How does it handle clipping and scissor rects?
- How are text and font rendering integrated?
- What batching or draw call optimization does it do?

## Animation & Transitions

- Is there a built-in animation system? How does it interpolate between states?
- How are transitions triggered and how do they interact with layout?

## Extensibility

- How do you create a custom widget?
- How customizable is styling/theming?
- What are the integration points for custom rendering backends?

## Design Takeaways

- What are the cleverest ideas in this codebase worth stealing?
- What are the pain points or limitations users commonly hit?
- How does this compare to other UI libraries solving the same problem?
```
