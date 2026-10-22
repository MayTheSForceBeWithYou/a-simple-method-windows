# Prose Technical Flags

Tracks reviewer doubts for the Windows port prose (PR #7) and Jack listings on `cursor/jack-listings-exercises-401f` through **`d7cf480`**. **Do not rebase** onto harness PR #6 until asked. **Do not merge.**

Quoted listings in `lessons/*/LESSON.md` are from PR #5 at `d7cf480`.

**ml64 CI:** Exit values are confirmed by the Windows ml64 CI on that tip ([run 39708631683](https://github.com/MayTheSForceBeWithYou/a-simple-method-windows/actions/runs/39708631683)), not by hand traces. The harness compares the full 32-bit `ExitProcess` status (not `exit AND 0FFh`).

## Resolved in listings (Jack branch) — prose now matches

| Flag | Resolution |
|------|------------|
| L00 hello RBX vs `[rsp+32]` | `02-hello-world` uses `sub rsp, 48` / `.allocstack 48` after one `push rbx`; fifth `WriteFile` arg does not overwrite saved RBX. |
| L00 `07-stderr-output` | Writes `"Error message"` with **no CRLF**. `bytes_written` is `DWORD`. Plain `main PROC`, `sub rsp, 56`, HANDLE stays in RAX then RCX. Header: `Expected output: (to stderr) Error message`. Exit **0**. |
| L01 `08-size-specifiers` | `WORD PTR [rbx+1], 4342h` (MASM hex, not a leading `0x`). |
| L02 `08-test-instruction` | Binary literal is `101b`. ml64 CI assembled it. |
| L04 frame-pointer forms | `07-frame-pointer.asm` form 1: `lea rbp,[rsp+48]` + `.setframe rbp, 48` / `.allocstack 48`. The `.SETFRAME` offset is 48 (multiple of 16, ≤ 240); it does not have to equal the allocation. Form 2 in the same file: `sub rsp, 40`. `08-rbp-pushreg-only.asm` is `.pushreg rbp` only (`sub rsp, 32`). |
| L04 `01-push-pop` header | NASM/SysV comment is gone. Quote is verbatim. |
| L04 `04-nonvolatile-regs` | `main` is `push rbx` / `.pushreg rbx` / `sub rsp, 32` — aligned 1-push frame. `ExitProcess` is called with the frame still live (no teardown / no extra `sub rsp, 40`). Exit **42** (or **1** if clobbered). |
| L04 `06-sum3-example` alignment | `main` uses aligned `sub rsp,40` before `call sum3` (0 pushes). |
| L05 `04-recursive-sum` frame | `push rbx` / `.pushreg rbx` / `sub rsp, 32` / `.allocstack 32` / `mov rbx, rcx` / `add rax, rbx`. Aligned 1-push model. Shared `done:` is `add rsp, 32` / `pop rbx` / `ret`. Exit **15**. |
| L07 `01-bit-operations` | MASM hex `0FFh` / `0Fh`; OR path is `8` / `4`; `sub rsp, 40`; exit **12**. |
| L07 `17-rgb-extract-no-mask` | Header `Expected exit: 65451` (`0FFABh`). Full 32-bit status; harness no longer keeps 171. |
| L07 `10` / `11` / `15` / `16` comments | Hex in comments is now `h` suffix (`0F0h`, `055h`, `00F0h`, `0ABCDEFh`). |
| L07 `ror` | `18-ror-rotate.asm`: `ror al, 1` on 1 → 128. Quoted; exit **128**. |
| L08 `02-open-read-file` / `05-file-mapping` | CI exit **72** (`'H'` from `test.txt` after listing 01). |
| L08 `06-get-process-id` | `test eax, eax` / `seta cl` — exit **1** (PID > 0), not `and eax, 7Fh`. |
| L08 `13-open-missing-get-last-error` | Path `C:\no\such\file.txt` → **3** (`ERROR_PATH_NOT_FOUND`), not 2 (`ERROR_FILE_NOT_FOUND`). |
| L08 pipe / heap | `15-create-pipe.asm`: `bytesRead` kept in EBX across `CloseHandle`, then `mov ecx, ebx` — exit **3**. `16-heap-alloc-sum.asm`: three `.pushreg` (RDI/RSI/RBX) + `sub rsp, 32`; sum **16**. |
| L08 block 7 | `14-set-file-pointer-begin.asm` added. |
| L09 `06-conditional-assembly` | `DEBUG` commented out → `xor ecx, ecx`; CI exit **0**. |
| L09+ stack alignment (Bruce) | Entry RSP≡8 (mod 16): 0 pushes → `sub rsp,40`; 1 push → `sub rsp,32`; 2 pushes → `sub rsp,40`; `.allocstack` matches `sub`; extra stack args bump minimum. |
| L09 missing `01-*` / `12-*` / `TEXTEQU` / `=` in `REPT` / NMake | `21-status-equ-zero` (0), `22-exit-code-include` + `22-exit-code.inc` (0), `23-textequ-exit` (42), `24-rept-counter-assign` (4), `25-nmake-driver` + `Makefile.mak` (0). |
| L10 `01`–`04` names | Live count is `buf_len` (not `length`). |
| L10 RIP-relative buffers | `lea r10, buffer` / `lea r10, buf` then `[r10+…]` (listings `01`–`08`, `11`–`14`, `20`). |
| L10 `10-gap-empty-init` | Header `Expected exit: 4096`. Full 32-bit status; harness no longer reports `4096 & 0FFh = 0`. |
| L10 `12-gap-move-left` exit | Byte load uses `r8` / `movzx edx` from `[r10+r8]`; exit **2**. |
| L10 kill-line | `21-kill-line.asm`: `"ab", 10, "cd"` / len 5 → copy newline+`cd`, exit **3**. |
| L11 listing exits | `01` → 1; `02` → 3; `03` → 16; `04` → 42 (CI). |
| L11 `13-stack-push-pop` | Index is `stack_sp` (not `sp`). `lea r10, stk`. |
| L11 `18-ring-tail-mask` | Header **3** (`7 AND 3`). |
| L11 skip / lexeme / align / Pratt | `19-skip-whitespace` (7), `20-copy-lexeme` (3), `21-arena-align-bump` (8), `22-pratt-binding-power` (14). |
| L12 listing exits | `03` → 9; `04` → 30 (CI). |
| L12 `05-bytecode-stack` | `bytecode` / `stack_mem` / `stack_sp`; header **9**. |
| L12 `06-bytecode-jmp` | Array is `bytecode` (not `code`). |
| L12 keyword / if-while / PE size | `07-keyword-let-match` (1), `08-if-while-codegen` (3), `09-pe-header-size` (64). |
| L13 listing exits | `01` → 5; `02` → 4; `03` → 6; `04` → 100 (CI). |
| L13 Q16 divide / lerp / SIMD | `06-q16-divide` (3), `07-lerp-fixed` (5), `08-simd-lane-sum` (`pshufd`/`paddd`, 10). No length-squared / Q8.8 listing. |
| L14 `01` / `02` / `03` | CI exits **0**. |
| L14 pitch / pack / clip / Bresenham | `06-pitch-pixel-offset` (40), `07-rgb-pack-low-byte` (3), `08-clip-half-open` (1), `10-bresenham-pixel-count` (`delta_x` / `delta_y`, 4). |
| L14 `09-vsync-ready-flag` | Three `Sleep(1)` waits, exit **3**. Each Sleep is a timer tick (~1–15.6 ms), not “one millisecond.” Sleep leaves the CPU free; a QPC spin burns a core. Not display vsync. Jack header comment says the same. |
| L09 `15-data-message` | Now a standalone executable (`main` / `ExitProcess(0)`) that still exports `PUBLIC message`. Exit **0**. |
| L09 `18-offset-equ` | `MSG_LEN EQU msg_end - msg` (2). Compares RIP-relative `lea` vs `OFFSET`, and a runtime span vs `MSG_LEN`. Success **2**. Failures **117** (span) and **118** (address). |
| L08 / L09 / L10 exercise READMEs | No `exercises/<lesson>/README.md`. Expected exits are in each file header under `exercises/`. |
| L08 exercise names | `04-virtualalloc`, `05-get-last-error-open`, `06-set-file-pointer`, `10-open-nul`, `11-read-nul`, `12-virtualalloc-read-write`, `13-virtualfree`, `14-heapalloc`, `16-qpc`, `17-duplicate-handle`, `19-overlapped-write`, `20-allocation-granularity`, `23-stretch-createpipe`. |
| L08 `09-close-handle` / `10-virtual-alloc-free` | BOOL tests use `test eax, eax` (`CloseHandle`, `VirtualFree`). `VirtualAlloc` still `test rax, rax` (pointer). |
| L17 `09-astar-f-score` / `10-manhattan-2axis` | First `\|d\|` kept in RBX across `abs_rax`. Exits **7** and **10**. |
| L15 `01` / `02` | CI exits **0** and **42**. |
| L15 rising-edge / chord / Sleep pad | `11-rising-edge` (1), `12-two-key-chord` (1). `13-sleep-frame-pad`: clamp keeps status in EBX, Sleep ms in ECX, then `mov ecx, ebx` — exit **1**. |
| L16 listing exits | `01` → 1; `02` → 53; `07` → 160; `09` → 2. |
| L16 `10-sprite-clip-margin` | Real clip (sx=6, sw=8, view=10 → `sw = view_w - sx` = **4**). Quoted; marker dropped. |
| L17 `01` / `02` | CI exits **105** and **5**. |
| L17 BFS / A* / 2-axis / hit-test | `08-bfs-visit-count` (`bfs_queue`, 5), `09-astar-f-score` (7), `10-manhattan-2axis` (10), `11-ui-hit-test` (1). |
| L18 `01` / `02` | CI exits **1** and **0**. |
| L18 `04`–`06` names | `grid_w` / `grid_h` / `tilemap` (not `width` / `map`). |
| L18 PK01 magic | `cmp`/`mov` use **`31304B50h`** — LE DWORD for bytes `P`,`K`,`0`,`1`. Not `314B5050h` (would be `P`,`P`,`K`,`1`). ZIP `PK\x01\x02` is **`02014B50h`**. |
| L18 track / 100-tick / P6 | `13-track-piece-connect` (1), `14-hundred-tick-loop` (100), `15-render-map-p6` (23 = 11-byte header + 12 RGB). |
| L01 `09` / `10` | **09** is block 9 only (LEA `5+5*2`, exit **15**). **10** is array sum (exit **100**) with listing-10 build line. |
| L06 `04-memcpy-loop` shadow | Now `sub rsp, 40` before the copy / `ExitProcess`. |

## CI-confirmed exits that used to be traces

These three were fixed at `ec4d05c` and remain CI-green at `d7cf480`:

- **L08 `15-create-pipe`** — exit **3** (`bytesRead` in EBX across `CloseHandle`).
- **L15 `13-sleep-frame-pad`** — exit **1** (status in EBX across `Sleep`).
- **L14 `09-vsync-ready-flag`** — exit **3** (three `Sleep(1)` waits). Still not a display vsync.

**L14 `08-clip-half-open`** — x = 5 vs 4. Only `cmp rax, 4` / `jl in_range` (`x < 4`). Outside path exits **1**. There is no `x >= 0` check. Full half-open form is `x >= lo && x < hi`.

## Open / intentionally unchanged (code not edited)

### Lesson 00 — `bytes_written` QWORD vs DWORD
**Doubt:** `WriteFile` wants `LPDWORD` (4 bytes). `07-stderr-output` now uses `DWORD`. Hello / two-writes still use `DQ`. Extra 4 bytes are harmless if nothing else shares the QWORD.

### Lesson 00 — `05-mov-data-movement.asm` RBX without save
**Why unchanged:** `ExitProcess` never returns; no caller to preserve RBX for.

### Lesson 00 — ExitProcess with no frame teardown
**Why unchanged:** After `PROC FRAME` + `push` + `sub rsp`, hello / two-writes call `ExitProcess` with the frame still live. `07-stderr-output` has no `FRAME` and also does not tear down. Correct because `ExitProcess` never returns.

### Lesson 03 — `07-test-zero-check.asm` RDI scratch
**Why unchanged:** Same never-returns `main` pattern.

### Lesson 01 — `03-register-indirect.asm` RSI without save
**Why unchanged:** Never-returns `main`.

### Lesson 08 — `16-heap-alloc-sum.asm` unused `HEAP_ZERO_MEMORY`
**Why unchanged:** `EQU 8` is never passed; `HeapAlloc` flags are 0; the fill is `rep stosb` of 1. Exit **16** does not depend on zero-init. RDI/RSI/RBX are saved (`push` / `.pushreg` ×3, `sub rsp, 32`).

### Lesson 05 — `04-recursive-sum.asm` comment wording
Jack reworded at `d7cf480` to “RSP is 16-byte aligned at callee entry after `call`.” That is still not “0 at the `call`.” Prose states the arithmetic: entry 8 + push 8 + `sub rsp, 32` ⇒ 0 mod 16 at the `call`. Quote is verbatim.

### Lesson 09 — `11-macro-local-list.asm` unused LOCAL names
**Why unchanged:** Teaches LOCAL declaration syntax; exit 2 matches two `inc rcx` expansions (or the following `mov ecx, 2`).

### Lesson 09 — `15-data-message.asm` / dual `add_two_numbers`
**Why unchanged:** Documented link pairs (05+helper, 19+20). Listing 15 now also has a `main` that exits 0.

### Lesson 10 — `18-load-validate-magic.asm` in-memory only
**Why unchanged:** Drill compares `WORD` to `4445h` (`"ED"` LE); not a full `ReadFile` load.

### Lesson 10 — `17-save-length-prefix.asm` partial write
**Why unchanged:** Writes magic+length only (12 bytes); side-effect demo, exit 0.

### Lesson 11 — RSI/RDI scratch in older listings
**Why unchanged:** Several `main` + `ExitProcess` listings still omit nonvolatile saves. `19-skip-whitespace` now `push rsi` / `sub rsp, 32`; `20-copy-lexeme` now `push rsi` / `push rdi` / `sub rsp, 40`. Same Bruce alignment rule on the `ec4d05c` saves in L08 16, L10 21, L12 07, L13 06, L14 06/10, L17 08–11, L18 13. L14 09 no longer pushes RBX (uses EBX as a wait counter; `ExitProcess` never returns).

### Lesson 13 — no Q8.8 / length-squared listing
Still no `listings/` file. Exercises/solutions: `14-vec2-length2` exits **25** (3²+4²); `08-from-scratch-q8` exits **3**; `24-from-scratch-q8-mul` exits **5**. The 11 new L13 solutions at `d7cf480` do not add a listings file for those topics.

### Lesson 14 — `rep movsd` and DF
**Resolved in comments:** Listing comments document ABI DF-at-entry/return and the **cld before rep movs\*/ret** rule; `03-blit-copy.asm` code still has no `cld`.

### Lesson 14 — no flip / alpha / damage listing
Clip, Sleep pace, and Bresenham now have files. Double-buffer flip, alpha, and damage rects do not.

### Lesson 17 — no `parent[]` / panel y-cursor stack
BFS counts visits and does not store parents. Hit-test is the four-compare panel; there is no y-cursor stack listing.

## Pending on Jack (PR #5)

- **L05 `04-recursive-sum`:** comment now says 16-byte aligned at callee entry after `call`. At the `call` instruction RSP is 0 mod 16; callee entry is 8.

## Remaining LISTING-PENDING (no matching Jack file)

None. Every previous marker now has a quoted file (or the L09 stand-ins `21`/`22`/`25` for missing `01-*` / `12-*` / NMake). Topics still without a `listings/` file: L13 length-squared / Q8.8 (exercises exist); L14 flip / alpha / damage; L17 `parent[]` / panel y-stack; L12 local-slot allocation.
