# Prose Technical Flags

This file tracks technical doubts encountered during the Windows port prose rewrite (Phase 2, Monk).

Each entry includes:
- Lesson number and file
- Section or line reference
- Quoted text (if applicable)
- The specific doubt or question

A technical reviewer will verify and resolve these before final merge.

---

## Format

```
### Lesson NN — [Title]
**Section:** [section name]
**Doubt:** [description of uncertainty]
**Quoted text:** [relevant excerpt if applicable]
```

---

<!-- Entries added during rewrite will appear below -->

### Lesson 11 — Parsing & Data Structures
**Section:** Inline code blocks (lexeme buffer, linked lists, arena, stack, queue, etc.)
**Doubt:** The lesson contains ~18 inline code blocks showing algorithmic patterns (linked list walking, arena allocation, etc.). These blocks currently use Linux-style section directives (`section .bss`, `section .text`, `global _start`, `syscall`). Should these be updated to MASM syntax (`.data?`, `.code`, `main PROC`, `call ExitProcess`) for consistency, or left as-is because they are illustrative pseudocode showing platform-independent algorithms? The standalone exercises and solutions (handled by another author) are already in MASM syntax.
