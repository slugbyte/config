---
name: explore-opensource-library-usage
description: >
  Prompt template for exploring open-source code (extracted from paint/note).
  User will refine later.
---




A series of prompts for evaluating an open source C library for use in a project, and planning a Zig wrapper around it. Use these in order — each builds on the previous.

---

## Prompt 1: Quick Evaluation

```
I'm considering using this C library in my Zig project. create a note called <library-name>-quick-evaluation covering:

- What does this library do in one paragraph?
- What is the public API surface? List every public function with a one-line description.
- What are the hard requirements? (libc, pthreads, platform-specific APIs, other libs)
- What's the license?
- How actively maintained is it? When was the last meaningful commit?
- What are the known limitations or gotchas called out in the docs or issues?
- Are there simpler alternatives I should consider instead?
  
```

---

## Prompt 2: API Deep Dive

```
Now walk me through how to actually use this library, create a note called <library-name>-api-overview covering:

- What's the minimal usage example? Show the simplest possible complete program.
- What's the typical lifecycle? (init → configure → use → cleanup)
- What are the common usage patterns — show 2-3 realistic examples beyond the basics.
- What are the error conditions and how does the library report them? (return codes, errno, callbacks, asserts)
- What are the threading/reentrancy guarantees?
- Are there any hidden global state or init functions I need to be aware of?
- What configuration knobs exist at compile time vs runtime?
```

---

## Prompt 3: Internals for Integration

```
I need to understand the internals enough to integrate and debug this library, create a note called <library-name>-integration-overview:

- How does it handle memory allocation?
- Does it support custom allocators? If so, what's the interface? If not, where would I need to patch it in?
- What are the core internal data structures I'll see in a debugger?
- What compile-time defines affect behavior? List them all with what they do.
- What source files contain the actual implementation vs platform glue vs tests vs examples?
- How big is the compiled static library roughly? (object count, code size)
```

---

## Prompt 4: Building with Zig

```
Help me plan building this library as a static C library from my Zig build system, create a note called <library-name>-zig-build-system

- List every .c file that needs to be compiled for a minimal static build.
- List every include path that needs to be set.
- List every preprocessor define needed and what each controls.
- Are there any generated files or configure steps I need to replicate?
- Are there source files I can exclude for my platform (Linux/X11/Wayland)?
- Are there any compiler flags or warnings I need to suppress? (UB sanitizer issues, etc)
- Write me a skeleton `build.zig` function that builds this as a static library.
```

---

## Prompt 5: Zig Wrapper Design

```
Help me design a plan for a Zig wrapper for this library's API, called <library-name>-zig-wrapper-plan:

- For each public function, suggest a Zig-idiomatic signature. Consider:
  - Replacing pointer+length pairs with slices
  - Replacing error codes with Zig error unions
  - Replacing output parameters with multiple return values or structs
  - Replacing opaque handles with typed pointers
  - Replacing bitflag ints with packed structs or enums
- Which functions should be grouped into a Zig struct with methods?
- Where can I use Zig allocator interface to replace malloc/free?
- What C patterns should I hide entirely behind a nicer Zig API?
- Are there any lifetime or ownership patterns that Zig's type system could enforce?
- Show me a sketch of what the Zig API would look like for the 2-3 most common use cases.
```

---

## Prompt 6: Testing & Validation

```
Help me verify the integration works:

- What test cases does the library ship with? How do I run them?
- What are good minimal test inputs I can use to verify basic functionality?
- What edge cases should I test to make sure my build and wrapper are correct?
- What should I look for in the output to confirm correct behavior?
- Are there any known inputs that cause crashes or incorrect output in the library?
```