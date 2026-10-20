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

### Lesson 00 — listings/02-hello-world.asm and 07-stderr-output.asm
**Section:** Worked example / stderr listing (quoted verbatim)
**Doubt:** After `push rbx` then `sub rsp, 32`, the saved RBX lives at `[rsp+32]`. Both listings store 0 there as `WriteFile`'s 5th argument (`lpOverlapped`). That overwrites the saved nonvolatile. `ExitProcess` never returns, so the programs still exit 0. A returning epilogue that `pop rbx` would restore 0. Listing `06-write-two-messages.asm` allocates 40 bytes after two pushes and does not collide. Confirm whether the listings author intends this as a hidden bug for later, or whether the 5th-arg slot should be extra stack (`sub rsp, 40`/`48`).
**Quoted text:** `mov qword ptr [rsp+32], 0  ; arg5 (on stack): overlapped = NULL`

### Lesson 00 — listings/02-hello-world.asm bytes_written
**Section:** `.DATA? bytes_written DQ ?`
**Doubt:** `WriteFile`'s `lpNumberOfBytesWritten` is `LPDWORD` (4 bytes). The listing reserves a QWORD (8 bytes). Harmless if adjacent storage is unused; a DWORD would match the API. Not edited.

### Lesson 00 — listings/05-mov-data-movement.asm
**Section:** uses `rbx` without save/restore
**Doubt:** RBX is nonvolatile. `main` calls `ExitProcess` and never returns, so the process does not restore a caller. Flagging in case a reviewer wants returning-procedure discipline even in `main`.

### Lesson 03 — listings/07-test-zero-check.asm
**Section:** `mov rdi, 42` without saving RDI
**Doubt:** RDI is nonvolatile on Windows. `main` never returns. Same never-returns rationale as earlier listings.

### Lesson 02 — listings/08-test-instruction.asm
**Section:** `mov rax, 0b0101`
**Doubt:** Confirm ml64 in VS 2022+ accepts `0b` binary literals. If not, the listing would fail to assemble. Not edited.

### Lesson 01 — listings/03-register-indirect.asm
**Section:** `lea rsi, msg` without saving RSI
**Doubt:** RSI is nonvolatile on Windows. Same `ExitProcess` never-returns rationale as L00 listing 05. Listings 02/04/05/07/08 also use RBX without saving.

### Lesson 11 — Parsing & Data Structures
**Section:** Inline code blocks (lexeme buffer, linked lists, arena, stack, queue, etc.)
**Doubt:** The lesson contains ~18 inline code blocks showing algorithmic patterns (linked list walking, arena allocation, etc.). These blocks currently use Linux-style section directives (`section .bss`, `section .text`, `global _start`, `syscall`). Should these be updated to MASM syntax (`.data?`, `.code`, `main PROC`, `call ExitProcess`) for consistency, or left as-is because they are illustrative pseudocode showing platform-independent algorithms? The standalone exercises and solutions (handled by another author) are already in MASM syntax.
