# Prose Technical Flags

Tracks reviewer doubts for the Windows port prose (PR #7) and Jack listings on `cursor/jack-listings-exercises-401f` through `c59a87b` (includes `3530e13`). **Do not rebase** onto harness PR #6 until asked.

Synced to Jack’s `docs/PROSE_TECH_FLAGS.md` on that branch, plus remaining LISTING-PENDING markers in LESSON.md.

## Resolved in listings (Jack branch) — prose now matches

| Flag | Resolution |
|------|------------|
| L00 hello/stderr RBX vs `[rsp+32]` | Listings use `sub rsp, 48` / `.allocstack 48` after one `push rbx`; fifth `WriteFile` arg does not overwrite saved RBX. |
| L05 `04-recursive-sum` epilogue | Single `done:` path; recursive arm uses `add rax, [rsp+32]`; push comment notes RCX is volatile. |
| L07 `17-rgb-extract-no-mask` harness | Header `Expected exit: 171`; comment documents full code `0xFFAB` (65451). |
| L08 block 7 | `14-set-file-pointer-begin.asm` added. |
| L09+ stack alignment (Bruce, `c59a87b`) | Entry RSP≡8 (mod 16): 0 pushes → `sub rsp,40`; 1 push → `sub rsp,32`; 2 pushes → `sub rsp,40`; `.allocstack` matches `sub`; extra stack args bump minimum. |
| L10 `12-gap-move-left` exit | Byte load uses `r8`/`movzx edx`; exit **2** matches `gap_start`; shadow added. |
| L11 `18-ring-tail-mask` | Header **3** (`7 AND 3`). |
| L12 `05-bytecode-stack` | Header **9** (push 4, push 5, add). |
| L16 listing exits | `01` → 1; `02` → 53; `07` → 160; `09` → 2. |
| L16 `10-sprite-clip-margin` | Real clip (sx=6, sw=8, view=10 → `sw = view_w - sx` = **4**). Quoted in LESSON.md; LISTING-PENDING marker dropped. |
| L18 PK01 magic | `cmp`/`mov` use **`31304B50h`** — LE DWORD for bytes `P`,`K`,`0`,`1`. Not `314B5050h` (would be `P`,`P`,`K`,`1`). ZIP `PK\x01\x02` is **`02014B50h`**. |
| L01 `09` / `10` | **09** is block 9 only (LEA `5+5*2`, exit **15**). **10** is array sum (exit **100**) with listing-10 build line. |
| L04 `06-sum3-example` alignment | `main` uses aligned `sub rsp,40` before `call sum3` (0 pushes). |
| L04 frame-pointer forms | `07-frame-pointer.asm` form 1 uses `lea rbp,[rsp+40]` + `.setframe rbp, 40`; `08-rbp-pushreg-only.asm` is `.pushreg rbp` only. |
| L06 `04-memcpy-loop` shadow | Now `sub rsp, 40` before the copy / `ExitProcess`. |

## Open / intentionally unchanged (code not edited)

### Lesson 00 — `bytes_written` QWORD vs DWORD
**Doubt:** `WriteFile` wants `LPDWORD` (4 bytes); listings use `DQ`. Extra 4 bytes are harmless if nothing else shares the QWORD.

### Lesson 00 — `05-mov-data-movement.asm` RBX without save
**Why unchanged:** `ExitProcess` never returns; no caller to preserve RBX for.

### Lesson 00 — stderr header says `Expected stdout`
**Why unchanged:** Harness may key off the label; program writes to stderr via `STD_ERROR_HANDLE`. Confirm with Bruce harness PR #6 when rebasing.

### Lesson 00 — ExitProcess with no frame teardown
**Why unchanged:** After `PROC FRAME` + `push` + `sub rsp`, hello / two-writes / stderr call `ExitProcess` with the frame still live. Correct because it never returns.

### Lesson 02 — `08-test-instruction.asm` `0b` binary literals
**Why unchanged:** Depends on ml64 version; VS 2022+ toolsets generally accept `0b`.

### Lesson 03 — `07-test-zero-check.asm` RDI scratch
**Why unchanged:** Same never-returns `main` pattern.

### Lesson 04 — `01-push-pop.asm` NASM header comment
**Why unchanged:** Stale prose in header only; code is MS x64.

### Lesson 01 — `03-register-indirect.asm` RSI without save
**Why unchanged:** Never-returns `main`.

### Lesson 09 — `18-offset-equ.asm` exit vs `OFFSET msg`
**Why unchanged:** PE `.data` offset is often 0 at link time for the first symbol, but not guaranteed; listing documents low-byte expectation.

### Lesson 09 — `11-macro-local-list.asm` unused LOCAL names
**Why unchanged:** Teaches LOCAL declaration syntax; exit 2 matches two `inc rcx` expansions (or the following `mov ecx, 2`).

### Lesson 09 — `15-data-message.asm` / dual `add_two_numbers`
**Why unchanged:** Documented link pairs (05+helper, 19+20); data-only object has no `main` by design.

### Lesson 10 — `18-load-validate-magic.asm` in-memory only
**Why unchanged:** Drill compares `WORD` to `4445h` (`"ED"` LE); not a full `ReadFile` load.

### Lesson 10 — `17-save-length-prefix.asm` partial write
**Why unchanged:** Writes magic+length only (12 bytes); side-effect demo, exit 0.

### Lesson 11 — RSI/RDI scratch in listings
**Why unchanged:** `main` + `ExitProcess`; shadow space added in the alignment pass; nonvolatile discipline omitted for brevity in never-returning mains.

### Lesson 11 — `13-stack-push-pop.asm` label name `sp`
**Why unchanged:** **Do not copy `sp` as RSP** — verify ml64 binds to the `.DATA?` symbol in your build.

### Lesson 14 — `rep movsd` and DF
**Resolved in comments:** Listing comments document ABI DF-at-entry/return and the **cld before rep movs\*/ret** rule; `03-blit-copy.asm` code still has no `cld`.

## Remaining LISTING-PENDING (no matching Jack file)

- L07: `ror` (ROL only)
- L08: `CreatePipe` / `HeapAlloc` / `HeapFree` / `GetProcessHeap`
- L09: no `01-*`, no `12-*`, no `TEXTEQU`, no `=` inside `REPT`, no NMake `.asm`
- L10: kill-line
- L11: whitespace skip / lexeme copy; 8-byte arena align; Pratt/precedence
- L12: whole-word keywords; if/while codegen / locals / PE size
- L13: Q16 divide / lerp / SIMD
- L14: pitch/RGB-pack math; clip / vsync / Bresenham
- L15: rising-edge / chord; `Sleep` frame pad
- L17: BFS/A* / two-axis Manhattan; UI hit-test
- L18: track pieces / 100-tick loop / P6 map render
