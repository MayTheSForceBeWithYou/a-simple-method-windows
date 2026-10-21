# Prose Technical Flags

Tracks reviewer doubts for the Windows port prose (PR #7) and Jack listings on `cursor/jack-listings-exercises-401f` through `cc1b9c9` (includes `c59a87b` / `3530e13`). **Do not rebase** onto harness PR #6 until asked.

Synced to Jack’s `docs/PROSE_TECH_FLAGS.md` on that branch, plus remaining LISTING-PENDING markers in LESSON.md.

**ml64:** The `cc1b9c9` listings that filled the last pending topics have **not** been assembled with ml64. Exits below are hand traces against the source. Headers that disagree with the trace are flagged; prose quotes the files as written and does not invent a matching status.

## Resolved in listings (Jack branch) — prose now matches

| Flag | Resolution |
|------|------------|
| L00 hello/stderr RBX vs `[rsp+32]` | Listings use `sub rsp, 48` / `.allocstack 48` after one `push rbx`; fifth `WriteFile` arg does not overwrite saved RBX. |
| L05 `04-recursive-sum` epilogue | Single `done:` path; recursive arm uses `add rax, [rsp+32]`; push comment notes RCX is volatile. |
| L07 `17-rgb-extract-no-mask` harness | Header `Expected exit: 171`; comment documents full code `0xFFAB` (65451). |
| L07 `ror` | `18-ror-rotate.asm`: `ror al, 1` on 1 → 128. Quoted; exit **128**. |
| L08 block 7 | `14-set-file-pointer-begin.asm` added. |
| L08 pipe / heap | `15-create-pipe.asm` and `16-heap-alloc-sum.asm` added. Heap sum traces to **16**. Pipe header says **3**; see mismatch below. |
| L09+ stack alignment (Bruce, `c59a87b`) | Entry RSP≡8 (mod 16): 0 pushes → `sub rsp,40`; 1 push → `sub rsp,32`; 2 pushes → `sub rsp,40`; `.allocstack` matches `sub`; extra stack args bump minimum. |
| L09 missing `01-*` / `12-*` / `TEXTEQU` / `=` in `REPT` / NMake | `21-status-equ-zero` (0), `22-exit-code-include` + `22-exit-code.inc` (0), `23-textequ-exit` (42), `24-rept-counter-assign` (4), `25-nmake-driver` + `Makefile.mak` (0). |
| L10 `12-gap-move-left` exit | Byte load uses `r8`/`movzx edx`; exit **2** matches `gap_start`; shadow added. |
| L10 kill-line | `21-kill-line.asm`: `"ab", 10, "cd"` / len 5 → copy newline+`cd`, exit **3**. |
| L11 `18-ring-tail-mask` | Header **3** (`7 AND 3`). |
| L11 skip / lexeme / align / Pratt | `19-skip-whitespace` (7), `20-copy-lexeme` (3), `21-arena-align-bump` (8), `22-pratt-binding-power` (14). |
| L12 `05-bytecode-stack` | Header **9** (push 4, push 5, add). |
| L12 keyword / if-while / PE size | `07-keyword-let-match` (1), `08-if-while-codegen` (3), `09-pe-header-size` (64). |
| L13 Q16 divide / lerp / SIMD | `06-q16-divide` (3), `07-lerp-fixed` (5), `08-simd-lane-sum` (`pshufd`/`paddd`, 10). No length-squared / Q8.8 listing. |
| L14 pitch / pack / clip / QPC pace / Bresenham | `06-pitch-pixel-offset` (40), `07-rgb-pack-low-byte` (3), `08-clip-half-open` (1), `09-vsync-ready-flag` (3, QPC not vsync), `10-bresenham-pixel-count` (4). |
| L15 rising-edge / chord / Sleep pad | `11-rising-edge` (1), `12-two-key-chord` (1). `13-sleep-frame-pad` header says 1; see mismatch below. |
| L16 listing exits | `01` → 1; `02` → 53; `07` → 160; `09` → 2. |
| L16 `10-sprite-clip-margin` | Real clip (sx=6, sw=8, view=10 → `sw = view_w - sx` = **4**). Quoted; marker dropped. |
| L17 BFS / A* / 2-axis / hit-test | `08-bfs-visit-count` (5), `09-astar-f-score` (7), `10-manhattan-2axis` (10), `11-ui-hit-test` (1). |
| L18 PK01 magic | `cmp`/`mov` use **`31304B50h`** — LE DWORD for bytes `P`,`K`,`0`,`1`. Not `314B5050h` (would be `P`,`P`,`K`,`1`). ZIP `PK\x01\x02` is **`02014B50h`**. |
| L18 track / 100-tick / P6 | `13-track-piece-connect` (1), `14-hundred-tick-loop` (100), `15-render-map-p6` (23 = 11-byte header + 12 RGB). |
| L01 `09` / `10` | **09** is block 9 only (LEA `5+5*2`, exit **15**). **10** is array sum (exit **100**) with listing-10 build line. |
| L04 `06-sum3-example` alignment | `main` uses aligned `sub rsp,40` before `call sum3` (0 pushes). |
| L04 frame-pointer forms | `07-frame-pointer.asm` form 1 uses `lea rbp,[rsp+40]` + `.setframe rbp, 40`; `08-rbp-pushreg-only.asm` is `.pushreg rbp` only. |
| L06 `04-memcpy-loop` shadow | Now `sub rsp, 40` before the copy / `ExitProcess`. |

## Exit mismatches (hand-traced; not assembled)

### Lesson 08 — `15-create-pipe.asm` (header 3)

Write 3 / read 3 is the intended round trip. After `mov ecx, DWORD PTR bytesRead` the success path jumps to `cleanup`, which calls `CloseHandle` twice. Each call takes the HANDLE in RCX (volatile). `ExitProcess` therefore does **not** receive `bytesRead`. The fail-close path sets `ecx = 1` *after* those closes, so 1 is reachable on failure. Do not treat 3 as a measured process status.

### Lesson 15 — `13-sleep-frame-pad.asm` (header 1)

Clamp arm (elapsed ≥ 12, budget 10) does `xor rax, rax` / `mov ecx, 1` / `jmp do_sleep`. `do_sleep` then `mov r8d, edx` / `call Sleep` / `mov ecx, r8d`. On that path EDX is never written (leftover after `GetTickCount64`), and `Sleep` may clobber R8. The `ecx = 1` is the Sleep argument, not a preserved status. Header/user expect 1; a hand trace cannot confirm 1.

### Lesson 14 — `09-vsync-ready-flag.asm` (header 3, not a vsync)

EBX is incremented at the top of the loop and the wait runs only while EBX `< 3`. Exit is EBX = **3**, which matches the header. The wait body runs **twice**, not three times. This is `QueryPerformanceCounter` spinning until the counter advances by 1 tick — not a display vsync.

### Lesson 14 — `08-clip-half-open.asm` (header 1)

x = 5 vs 4. Only `cmp rax, 4` / `jl in_range` (`x < 4`). The outside path exits **1**, matching the header. There is no `x >= 0` check. Full half-open form is `x >= lo && x < hi`.

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

### Lesson 08 — `16-heap-alloc-sum.asm` unused `HEAP_ZERO_MEMORY`
**Why unchanged:** `EQU 8` is never passed; `HeapAlloc` flags are 0; the fill is `rep stosb` of 1. Exit **16** does not depend on zero-init. RSI/RDI/RBX unsaved (`ExitProcess`).

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

### Lesson 13 — no Q8.8 / length-squared listing
Jack filled divide, lerp, and SSE2 sum. Length-squared and Q8.8 remain prose-only (no filename to quote).

### Lesson 14 — `rep movsd` and DF
**Resolved in comments:** Listing comments document ABI DF-at-entry/return and the **cld before rep movs\*/ret** rule; `03-blit-copy.asm` code still has no `cld`.

### Lesson 14 — no flip / alpha / damage listing
Clip, QPC pace, and Bresenham now have files. Double-buffer flip, alpha, and damage rects do not.

### Lesson 17 — no `parent[]` / panel y-cursor stack
BFS counts visits and does not store parents. Hit-test is the four-compare panel; there is no y-cursor stack listing.

## Remaining LISTING-PENDING (no matching Jack file)

None. Every previous marker now has a quoted file (or the L09 stand-ins `21`/`22`/`25` for missing `01-*` / `12-*` / NMake). Topics still without a file, taught as prose only: L13 length-squared / Q8.8; L14 flip / alpha / damage; L17 `parent[]` / panel y-stack; L12 local-slot allocation.
