# Prose Technical Flags

This file tracks technical doubts encountered during the Windows port prose rewrite (Phase 2, Monk) and the Jack-listing re-sync (PR #5 listings on `cursor/jack-listings-exercises-401f`).

Each entry includes:
- Lesson number and file
- Section or line reference
- Quoted text (if applicable)
- The specific doubt or question

A technical reviewer will verify and resolve these before final merge.

Resolved and **removed** in this re-sync:
- L00 `02-hello-world` / `07-stderr-output` saved-RBX overwrite (`sub rsp, 32` after `push rbx`). Jack now uses `sub rsp, 48` / `.allocstack 48`. L00 `06-write-two-messages` still uses `sub rsp, 40` after two pushes.
- L05 `04-recursive-sum` recursive path `pop rcx` / `ret` without `add rsp, 32`. Jack now shares `done:` (`jmp done` from both paths; `add rax, [rsp+32]`; `add rsp, 32` / `pop rcx` / `ret`). Push comment now says RCX is volatile.

---

## Format

```
### Lesson NN — [Title]
**Section:** [section name]
**Doubt:** [description of uncertainty]
**Quoted text:** [relevant excerpt if applicable]
```

---

### Lesson 00 — listings/02-hello-world.asm and 07-stderr-output.asm bytes_written
**Section:** `.DATA? bytes_written DQ ?`
**Doubt:** `WriteFile`'s `lpNumberOfBytesWritten` is `LPDWORD` (4 bytes). Both listings reserve a QWORD (8 bytes). Harmless if adjacent storage is unused; a DWORD would match the API. Not edited.

### Lesson 00 — listings/07-stderr-output.asm header
**Section:** `Expected stdout: "Error message\n"`
**Doubt:** The program calls `GetStdHandle(-12)` and writes to stderr. The header still says `Expected stdout`. The run line `2>&1` merges streams for a console check. Confirm whether the harness keys off the `stdout` label or the handle.

### Lesson 00 — listings/05-mov-data-movement.asm
**Section:** uses `rbx` without save/restore
**Doubt:** RBX is nonvolatile. `main` calls `ExitProcess` and never returns, so the process does not restore a caller. Flagging in case a reviewer wants returning-procedure discipline even in `main`.

### Lesson 00 — ExitProcess with no frame teardown
**Section:** listings `02-hello-world`, `06-write-two-messages`, `07-stderr-output`
**Doubt:** After `PROC FRAME` + `push` + `sub rsp`, all three call `ExitProcess` with the frame still live (no `add rsp` / `pop`). Correct because `ExitProcess` never returns. Confirm this is the intended pattern and not a missing epilogue.

### Lesson 01 — listings/09-lea-vs-mov.asm and 10-array-sum.asm
**Section:** extra numbered copies
**Doubt:** These two files are CRLF copies of `06-lea-vs-mov.asm` and `07-array-sum.asm`. Headers still say `Listing 06` / `Listing 07` and the build lines still name the `06-` / `07-` objects. Lesson quotes 06 and 07 once. Confirm whether 09/10 should be deleted or given their own headers.

### Lesson 01 — listings/03-register-indirect.asm
**Section:** `lea rsi, msg` without saving RSI
**Doubt:** RSI is nonvolatile on Windows. Same `ExitProcess` never-returns rationale as L00 listing 05. Listings 02/04/05/07/08 also use RBX without saving.

### Lesson 02 — listings/08-test-instruction.asm
**Section:** `mov rax, 0b0101`
**Doubt:** Confirm ml64 in VS 2022+ accepts `0b` binary literals. If not, the listing would fail to assemble. Not edited.

### Lesson 03 — listings/07-test-zero-check.asm
**Section:** `mov rdi, 42` without saving RDI
**Doubt:** RDI is nonvolatile on Windows. `main` never returns. Same never-returns rationale as earlier listings.

### Lesson 04 — listings/01-push-pop.asm header
**Section:** comment "this lesson's NASM examples assume System V"
**Doubt:** Stale Linux leftover in the listing header. Code itself is MS x64. Not edited.

### Lesson 04 — listings/06-sum3-example.asm alignment vs 05-stack-alignment.asm
**Section:** `main` uses `sub rsp, 32` (listing 06) vs `sub rsp, 40` (listing 05)
**Doubt:** If `main` is entered with RSP ≡ 8 (mod 16), `sub rsp, 32` leaves RSP ≡ 8 at `call`. Listing 05's comments say RSP must be 16-byte aligned before CALL. Integer leaf `sum3` may still work. Confirm which allocation `main` should use.

### Lesson 04 — listings/07-frame-pointer.asm
**Section:** `PROC FRAME` with `mov rbp, rsp` but no `.setframe rbp`
**Doubt:** Microsoft unwind docs typically pair a frame pointer with `.setframe rbp, 0` (or similar). Confirm whether ml64 requires it here.

### Lesson 06 — listings/04-memcpy-loop.asm
**Section:** `call ExitProcess` with no `sub rsp, 32`
**Doubt:** The memcpy drill never allocates shadow space. `ExitProcess` does not return, so this usually works. Same never-returns / missing-home-space pattern as several later listings.

### Lesson 07 — no `ror` listing
**Section:** rotate
**Doubt:** Jack has `12-rol-rotate.asm` (ROL only). `ror` is taught in prose. Lesson keeps `<!-- LISTING-PENDING: no Jack listing for ror -->`.

### Lesson 08 — no pipe/heap listings
**Section:** other kernel services
**Doubt:** No Jack listing for `CreatePipe`, `HeapAlloc`, `HeapFree`, or `GetProcessHeap`. `VirtualAlloc` / `GetCurrentProcessId` / `QueryPerformanceCounter` are listed. Lesson keeps a LISTING-PENDING marker for the missing APIs.

### Lesson 09 — missing 01 and 12; TEXTEQU / NMake
**Section:** numbered gaps
**Doubt:** Jack has no `01-*.asm` and no `12-*.asm`. `constants.inc` is the shared-header stand-in for 12. No listing uses `TEXTEQU` or `=` reassignment inside `REPT`. No Jack `.asm` is an NMake/Makefile.

### Lesson 09 — listings/17-writefile-rip-relative.asm segment order
**Section:** `EXTRN` under `.CODE`, then `.DATA` / `.DATA?`, then `main PROC` with no second `.CODE`
**Doubt:** Uncertain whether ml64 still emits `main` in `.text` or assembles the procedure into the data segment.

### Lesson 09 — listings/18-offset-equ.asm exit
**Section:** `Expected exit: 0 (low byte of OFFSET msg…)` vs `mov ecx, MY_ADDR`
**Doubt:** `MY_ADDR EQU OFFSET msg`. On a PE the low 32 bits of that offset are not necessarily 0. Not verified on Windows.

### Lesson 09 — listings/11-macro-local-list.asm
**Section:** unused `LOCAL` names; `mov ecx, 2`
**Doubt:** Declares `LOCAL label1, label2, label3` and never uses them. Two `inc rcx` expansions would leave 2, but the listing then `mov ecx, 2`. Exit 2 is the immediate, not the increment result.

### Lesson 09 — listings/15-data-message.asm
**Section:** link object only
**Doubt:** `PUBLIC message`, no `main`. No Jack driver `EXTRN`s `message`.

### Lesson 09 — two `add_two_numbers` objects
**Section:** `05-multifile-helper.asm` and `20-add-two-numbers.asm`
**Doubt:** Same symbol. Pair 05-helper with 05-main, and 20 with 19. Do not link both helpers into one exe.

### Lesson 09 — missing shadow space
**Section:** `02-macro-with-local`, `03-rept-repetition`, `04-multi-param-macro`, `05-multifile-main`
**Doubt:** `call ExitProcess` without `sub rsp, 32`. Same never-returns rationale.

### Lesson 10 — listings/12-gap-move-left.asm exit vs comment
**Section:** expected exit 2
**Doubt:** After `dec rax` (index 2), `mov al, BYTE PTR buf[rax]` loads `'Q'` (`51h`) into AL without zero-extending, so RAX becomes 81. `mov ecx, eax` would exit 81, not 2. The byte copy to `buf[4]` is the intended move; the index in RAX is clobbered. Not executed here (no ml64).

### Lesson 10 — listings/10-gap-empty-init.asm
**Section:** `gap_end - gap_start` = 4096
**Doubt:** `mov ecx, eax` passes 4096. A harness that keeps the low 8 bits reports 0. Prose states that.

### Lesson 10 — listings/17-save-length-prefix.asm
**Section:** writes magic + length
**Doubt:** Writes magic (4) and `len` (8, value 0) only — no `WriteFile` of buffer contents. Success exit is 0. Side effect: 12-byte `editor.save`.

### Lesson 10 — listings/18-load-validate-magic.asm
**Section:** in-memory compare
**Doubt:** `cmp WORD PTR magic, 4445h`; exit 1 on match. No `CreateFileA` / `ReadFile`. Drill semantics are inverted from a real editor load.

### Lesson 10 — listings/14-line-start-scan.asm
**Section:** RSI as cursor
**Doubt:** Uses RSI (nonvolatile) without saving it; `main` calls `ExitProcess`. `mov ecx, ecx` is a no-op before the call.

### Lesson 10 — listings/20-insert-shift-jl.asm
**Section:** `put_byte` stores at `buf[1]`
**Doubt:** Store is `BYTE PTR buf[1]`, not `buf[cur]`. Correct only because `cur` is 1.

### Lesson 10 — no kill-line listing
**Section:** kill-line
**Doubt:** None of 01–20 implement kill-line. Lesson keeps LISTING-PENDING. Drill is under `exercises/`.

### Lesson 11 — RSI/RDI scratch and missing shadow
**Section:** listings 05, 07, 08, 09, 10, 14 and most ExitProcess calls
**Doubt:** RSI/RDI used as scratch (Linux SysV habit). On Windows they are nonvolatile. Files are `main` + `ExitProcess`, so the clobber is not observed. Almost every listing also omits `sub rsp, 32`.

### Lesson 11 — listings/13-stack-push-pop.asm name `sp`
**Section:** `sp QWORD ?` / `mov sp, 0` / `inc sp`
**Doubt:** `sp` is the 16-bit name of RSP. Whether ml64 treats this as the `.DATA?` label or as the register is unresolved. If it is the register, `mov sp, 0` wrecks the stack. Do not copy the name.

### Lesson 11 — listings/18-ring-tail-mask.asm exit
**Section:** comment vs bits
**Doubt:** Comment says expected exit 0. Code is `7 AND 3` → 3. Prose follows the bits.

### Lesson 11 — no whitespace-skip / alignment / Pratt listings
**Section:** lexer extras, arena align, precedence
**Doubt:** No Jack listing for whitespace skip, lexeme-buffer copy, 8-byte bump alignment, or Pratt binding powers. Lesson keeps LISTING-PENDING markers.

### Lesson 12 — listings/04-bytecode-interp.asm ADD stub
**Section:** `op_add`
**Doubt:** ADD is `add rax, 10` (hardcoded), not a two-pop add. First LOAD 10 is overwritten. Halt opcode is 3 here; halt is 0 in listing 05.

### Lesson 12 — listings/05-bytecode-stack.asm exit and name `st`
**Section:** expected exit 5 vs 4+5
**Doubt:** Stream is push 4, push 5, add, halt. Traced exit is 9. Comment says 5. Stack label is `st` (x87 `ST(0)` collision risk).

### Lesson 12 — listings/06-bytecode-jmp.asm
**Section:** not a jump interpreter
**Doubt:** Loads the first byte (3), increments, then `add rsi, rax`. Displacement 2 is never read. Exit is 0 (`xor ecx, ecx`).

### Lesson 12 — no keyword / if-while / PE listings
**Section:** compiler extras
**Doubt:** No Jack listing for whole-word keyword matching, if/while codegen, local-slot allocation, or PE header size. Lesson keeps LISTING-PENDING markers.

### Lesson 13 — listings/04-q16-clamp.asm not Q16
**Section:** filename vs operands
**Doubt:** Comment/filename say Q16.16. Operands are integers 150 and 100; there is no shift. Exit 100.

### Lesson 13 — no Q16 divide / lerp / SIMD listings
**Section:** extras
**Doubt:** No Jack listing for Q16 divide, lerp, length-squared, Q8.8, or SSE/XMM. None of the five Jack files use XMM. Lesson keeps LISTING-PENDING.

### Lesson 14 — listings/01-pixel-plot.asm and 02-fill-rect.asm
**Section:** offset / pitch
**Doubt:** Plot stores at `[fb+0]`, not `y*pitch+x*bpp`. Fill writes 100 consecutive dwords — not a 2-D pitched rect. No Jack listing for pitch math, RGB pack, clip, vsync, or Bresenham.

### Lesson 14 — listings/03-blit-copy.asm
**Section:** `rep movsd` without `cld`
**Doubt:** Relies on process-start DF=0. Lesson 06 taught `cld` before `rep movs*`.

### Lesson 15 — listings/05-peek-console-input.asm
**Section:** imported `PeekConsoleInputA` never called
**Doubt:** The file imports the API, calls only `GetStdHandle(-10)`, and exits 0. No rising-edge, chord, or `Sleep` listing. Lesson keeps LISTING-PENDING for those.

### Lesson 15 — listings/01-qpc-timing.asm
**Section:** calls QPC and QPF, exits 0
**Doubt:** Does not subtract two counters or divide by frequency. Listing `02-delta-time` uses a canned 42.

### Lesson 16 — listings/07-spatial-hash-cell.asm exit
**Section:** header expected 0
**Doubt:** `40 >> 3` → 5, `5 * 32` → 160. `mov ecx, ebx` / `ExitProcess`. Traced exit 160. Header says 0. Prose follows the multiply.

### Lesson 16 — listings/09-anim-frame.asm exit
**Section:** header expected 1
**Doubt:** `div` of 25 by 10; `mov ecx, eax` is the quotient **2**. EDX remainder 5 is unused. Header says 1. Prose follows the quotient.

### Lesson 16 — no partial-sprite clip listing
**Section:** clip
**Doubt:** `10-sprite-clip-margin.asm` exits 0 with no inset math. Lesson keeps LISTING-PENDING for a true sx/sw clip.

### Lesson 17 — listings/02-manhattan-dist.asm
**Section:** one axis
**Doubt:** Computes `|10-5|` only (exit 5). No two-axis Manhattan, BFS, or A* listing. Lesson keeps LISTING-PENDING for those.

### Lesson 17 — no UI hit-test listing
**Section:** UI
**Doubt:** No four-compare hit test or panel y-cursor stack. Focus wrap is listing 06. Lesson keeps LISTING-PENDING.

### Lesson 18 — listings/03-load-header-magic.asm exit
**Section:** header expected 1
**Doubt:** Buffer is `"PK01"` → first DWORD `31304B50h`. Compare immediate is `314B5050h` (`"PPK1"`). `jne bad` is taken; traced exit **0**. Header says 1. Listing 12 pre-seeds `314B5050h` and can still exit 1 on the missing-file / harness path. A successful `ReadFile` of listing 11's `park.sav` (real ASCII `"PK01"`) would fail the same compare.

### Lesson 18 — no track / 100-tick / P6 listing
**Section:** capstone extras
**Doubt:** No Jack listing for track-piece types, a 100-tick loop, or P6 PPM map render. Lesson keeps LISTING-PENDING.

### Cross-cutting — missing shadow space and never-returning `main`
**Section:** many L09–L18 drills
**Doubt:** A large set of Jack programs call `ExitProcess` with no `sub rsp, 32` and use RSI/RDI/RBX without saving. `main` never returns, so ABI damage is not observed. Returning procedures must not copy that pattern.
