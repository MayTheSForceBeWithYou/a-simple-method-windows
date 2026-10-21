# Lesson 15 — Input, Timing, Game Loop

Lesson 14 gave you pixels. This lesson gives you **time** and **input** on Windows: `QueryPerformanceCounter` plus `QueryPerformanceFrequency` for a high-resolution tick, a frame delta you bank into an accumulator, fixed-size simulation steps with a spiral-of-death clamp, hold-to-repeat and mouse Manhattan, and a non-blocking look at the console input buffer via `GetStdHandle` / `PeekConsoleInputA`. By the end you treat a frame as **input → bank dt → update(fixed dt) → render → wait**, and you see why a second `xor rdx, rdx` is not optional before the next unsigned `div`.

Windows user-mode code does not call `clock_gettime` or `poll`. You import `kernel32` functions, place arguments in RCX / RDX / R8 / R9, allocate 32 bytes of shadow space before every `call`, and read BOOL or HANDLE returns in RAX.

## What this lesson asks of you

You measure elapsed time as a counter difference, not as a wall-clock `timespec`. You convert that difference into a step count by matching units (microseconds to milliseconds, then milliseconds to steps) and you **clamp** the step count so one slow frame cannot cascade. You store a held key as a byte, fire a repeat when a hold counter reaches a threshold, and report mouse motion as Manhattan `|dx| + |dy|` after a sign test. You obtain the console input HANDLE with `GetStdHandle` and you know that `PeekConsoleInputA` is the non-blocking peek — even when a listing declares the import and then exits without calling it. You leave `rdx` zero immediately before every unsigned `div`, because the previous `div` wrote its remainder there.

## High-resolution ticks: QueryPerformanceCounter

`QueryPerformanceFrequency` writes a QWORD ticks-per-second through the pointer in RCX. `QueryPerformanceCounter` writes a QWORD monotonic tick through RCX. Both return a BOOL in RAX (nonzero = success). Elapsed seconds are `(end - start) / frequency`. Elapsed milliseconds are `(end - start) * 1000 / frequency`. That is the Win32 counterpart of a monotonic clock, not `GetTickCount` (millisecond granularity, wraps) and not a Linux `timespec`.

Listing `01-qpc-timing` is the call pair. `main PROC FRAME` records `sub rsp, 32` / `.allocstack 32` so the unwinder sees the shadow space. RCX receives `&freq`, then `&counter`. The listing does **not** subtract two counters, does **not** divide by frequency, and does **not** test the BOOL returns. It zeros ECX and calls `ExitProcess`. Expected exit: **0**.

```asm
; QueryPerformanceCounter timing, exit 0
.DATA?
counter QWORD ?
freq QWORD ?
.CODE
EXTRN QueryPerformanceCounter:PROC
EXTRN QueryPerformanceFrequency:PROC
EXTRN ExitProcess:PROC
main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    lea rcx, freq
    call QueryPerformanceFrequency
    lea rcx, counter
    call QueryPerformanceCounter
    xor ecx, ecx
    call ExitProcess
main ENDP
END

```

A later frame will keep the previous counter, call `QueryPerformanceCounter` again, subtract, and scale. This listing only proves the imports and the shadow space.

## Delta time as a subtraction

**Delta time** (dt) is the elapsed time since the last stamp. Listing `02-delta-time` does not call the counter APIs. It stores hardcoded QWORDs `prev_time = 100` and `curr_time = 142`, subtracts, and exits the difference. `mov ecx, eax` passes the low 32 bits of that difference to `ExitProcess`. Expected exit: **42**.

```asm
; Calculate delta time, exit with dt
.DATA?
prev_time QWORD ?
curr_time QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    mov prev_time, 100
    mov curr_time, 142
    mov rax, curr_time
    sub rax, prev_time
    mov ecx, eax
    call ExitProcess
main ENDP
END

```

The listing has no `PROC FRAME` and no `sub rsp, 32`. The Microsoft x64 ABI still requires 32 bytes of home space before `call ExitProcess`; this file omits it. The subtraction itself is the lesson: dt is `curr - prev`, here 42, in whatever unit you assigned to those stamps.

## Hold-to-repeat

A held key can **repeat** after a threshold. Store the key as a byte (0 = up, 1 = down) and keep a hold counter. Listing `03-hold-repeat` writes `key = 1`, zeros `hold_count`, then — because the key compares equal to 1 — executes three `inc hold_count` instructions. That is three frames of hold, unrolled, not a loop. `cmp hold_count, 3` / `jl no_fire` fails (3 is not less than 3), so ECX becomes 1. Expected exit: **1**.

```asm
; Listing 03: Key hold repeat counter (LESSON.md block 3)
; Expected exit: 1
; Expected stdout: (none)

.DATA?
key BYTE ?
hold_count QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     BYTE PTR key, 1
    mov     hold_count, 0
    cmp     BYTE PTR key, 1
    jne     not_held
    inc     hold_count
    inc     hold_count
    inc     hold_count
not_held:
    cmp     hold_count, 3
    jl      no_fire
    mov     ecx, 1
    jmp     done
no_fire:
    xor     ecx, ecx
done:
    call    ExitProcess
main ENDP
END

```

If the key byte were 0, the three increments would be skipped, `hold_count` would stay 0, and the listing would take `no_fire` and exit 0. A live game increments once per frame while the key stays down and resets the counter on release. This listing is the threshold test: fire when the count is at least 3.

A **rising edge** is the frame where the key goes from up to down: `prev == 0 && cur == 1`. Listing `11-rising-edge` loads EAX = 0 and EBX = 1, checks both, and exits 1 on the match. Expected exit: **1**. Either compare failing would zero ECX.

```asm
; Listing 11: Rising edge prev==0 && cur==1
; Expected exit: 1
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     eax, 0
    mov     ebx, 1
    cmp     eax, 0
    jne     not_rising
    cmp     ebx, 1
    jne     not_rising
    mov     ecx, 1
    jmp     exit_proc
not_rising:
    xor     ecx, ecx
exit_proc:
    call    ExitProcess
main ENDP
END
```

A **chord** is two keys down at once. Listing `12-two-key-chord` writes `key_w = 1` and `key_shift = 1`, then `and`s those bytes. 1 AND 1 is 1. Expected exit: **1**. Either key 0 would exit 0.

```asm
; Listing 12: Two-key chord (W and Shift both down)
; Expected exit: 1
; Expected stdout: (none)

.DATA?
key_w BYTE ?
key_shift BYTE ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     BYTE PTR key_w, 1
    mov     BYTE PTR key_shift, 1
    movzx   eax, BYTE PTR key_w
    and     al, BYTE PTR key_shift
    movzx   ecx, al
    call    ExitProcess
main ENDP
END
```

## Mouse delta as Manhattan distance

Mouse motion is a pair `(dx, dy)` since the last sample. **Manhattan distance** is `|dx| + |dy|`. Listing `04-mouse-delta-sum` loads `rax = 5`, `rbx = -2`, **tests the sign of RBX**, negates only when the sign bit is set (`jns pos` skips `neg`), then adds. `|-2|` becomes 2; `5 + 2 = 7`. Expected exit: **7**.

```asm
; Listing 04: Manhattan sum of mouse deltas (LESSON.md block 4)
; Expected exit: 7
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     rax, 5
    mov     rbx, -2
    test    rbx, rbx
    jns     pos
    neg     rbx
pos:
    add     rax, rbx
    mov     ecx, eax
    call    ExitProcess
main ENDP
END

```

The sign test is load-bearing. An unconditional `neg rbx` would be correct for this particular −2 and wrong for a positive `dy` (it would subtract instead of add). Trace `dy = 2` without the test: `neg` yields −2, `5 + (−2) = 3`, not 7.

## Non-blocking console input: GetStdHandle and PeekConsoleInputA

Lesson 08's `ReadFile` on the console blocks until a line arrives if `ENABLE_LINE_INPUT` is set. A game loop cannot block. `PeekConsoleInputA` reads `INPUT_RECORD` entries from the console input buffer **without removing them** and **without waiting** for a key. Arguments: HANDLE in RCX, buffer in RDX, record count in R8, pointer to a DWORD receive-count in R9. `GetStdHandle` with RCX = −10 (`STD_INPUT_HANDLE`) returns that HANDLE.

Listing `05-peek-console-input` declares `GetStdHandle`, `PeekConsoleInputA`, and `ExitProcess`. It allocates 64 bytes (`sub rsp, 64` / `.allocstack 64`), calls `GetStdHandle(-10)`, then **does not call `PeekConsoleInputA`**. The comment in the file states the harness has no input pending. ECX is zeroed and the process exits. The HANDLE in RAX is discarded. Expected exit: **0**.

```asm
; Listing 05: Non-blocking stdin readiness (LESSON.md block 5)
; Expected exit: 0
; Expected stdout: (none)

.DATA?
key BYTE ?

.CODE
EXTRN GetStdHandle:PROC
EXTRN PeekConsoleInputA:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog

    mov     rcx, -10
    call    GetStdHandle
    ; No input pending in harness: exit 0 without blocking read
    xor     ecx, ecx
    call    ExitProcess
main ENDP
END

```

A complete peek would pass that HANDLE to `PeekConsoleInputA`, look at the DWORD count and at `INPUT_RECORD.EventType` (`KEY_EVENT` = 1, `MOUSE_EVENT` = 2), and only then decide whether to `ReadConsoleInputA` or to proceed with no new event. This listing is the non-blocking contract: return immediately with status 0 when nothing is consumed.

Cooked console mode still line-buffers `ReadFile`. `PeekConsoleInputA` talks to the input record buffer, which is a different path. For per-keystroke gameplay you also clear `ENABLE_LINE_INPUT` and `ENABLE_ECHO_INPUT` with `GetConsoleMode` / `SetConsoleMode` (lesson 10).

## Fixed timestep: divide, then clamp, then match units

A **fixed timestep** runs the simulation in constant slices (16 ms here) so the park economy and guest motion are deterministic. Frame time varies. You convert elapsed milliseconds to a step count with unsigned `div`, then cap that count.

### Steps from a millisecond delta

Listing `06-fixed-step-div` divides 50 by 16. `xor rdx, rdx` is required: `div rbx` divides the 128-bit value `rdx:rax` by RBX, writes the quotient to RAX and the remainder to RDX. 50 / 16 = 3 remainder 2. `mov ecx, eax` exits the quotient. Expected exit: **3**. The remainder 2 is leftover frame time, not the status.

```asm
; Listing 06: Fixed timestep division (LESSON.md block 6)
; Expected exit: 3
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     rax, 50
    xor     rdx, rdx
    mov     rbx, 16
    div     rbx
    mov     ecx, eax
    call    ExitProcess
main ENDP
END

```

### Spiral-of-death clamp

If one frame costs 100 ms, 100 / 16 = 6 steps. Those six updates might cost another 100 ms, and the simulation never catches up. **Clamp** the step count to a maximum (3 here).

Listing `07-timestep-clamp` divides 100 by 16 (`xor rdx, rdx` first), gets 6 in RAX, compares to 3, and because 6 is **not** below-or-equal (`jbe ok` fails) writes 3 into RAX. Expected exit: **3**.

```asm
; Listing 07: Clamp simulation steps (LESSON.md block 7)
; Expected exit: 3
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     rax, 100
    xor     rdx, rdx
    mov     rbx, 16
    div     rbx
    cmp     rax, 3
    jbe     ok
    mov     rax, 3
ok:
    mov     ecx, eax
    call    ExitProcess
main ENDP
END

```

`jbe` is unsigned. A negative step count is not a thing this listing produces; the compare is `rax` against the immediate 3 after an unsigned `div`.

### Convert microseconds before you divide by a millisecond step

A counter difference is often in microseconds or raw ticks. The step size here is 16 **milliseconds**. Listing `08-dt-units-convert` starts with 16000 (microseconds), divides by 1000 to get 16 ms, **zeros RDX again**, then divides by 16. Expected exit: **1**.

```asm
; Listing 08: Microseconds to fixed steps (LESSON.md block 8)
; Expected exit: 1
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     rax, 16000
    xor     rdx, rdx
    mov     rbx, 1000
    div     rbx
    xor     rdx, rdx
    mov     rbx, 16
    div     rbx
    mov     ecx, eax
    call    ExitProcess
main ENDP
END

```

Listing `10-fixed-step-count` is the same conversion written as a second copy: 16000 µs → 16 ms → 1 step. Expected exit: **1**.

```asm
; Listing 10: Single fixed step from microseconds (LESSON.md block 10)
; Expected exit: 1
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     rax, 16000
    xor     rdx, rdx
    mov     rbx, 1000
    div     rbx
    xor     rdx, rdx
    mov     rbx, 16
    div     rbx
    mov     ecx, eax
    call    ExitProcess
main ENDP
END

```

Never divide 16000 by 16 and call the quotient a step count. That treats microseconds as milliseconds and reports 1000 steps for a single 16 ms frame.

## Accumulator: bank time, spend whole steps

An **accumulator** stores leftover dt. Each frame you add the new dt. While the accumulator holds at least one step, you subtract the step and run one `update`. A clamp on the iteration count sits beside the `accum >= step` test.

Listing `09-frame-accum-loop` writes `accum = 32`, zeros RCX (the step counter), and loops:

1. `cmp accum, 16` / `jl render` — not enough time left, stop.
2. `cmp rcx, 3` / `jge render` — already ran the clamp of 3 steps, stop.
3. `sub accum, 16` / `inc rcx` / `jmp update_loop`.

32 ≥ 16 and RCX = 0 → spend 16, RCX = 1.  
16 ≥ 16 and RCX = 1 → spend 16, RCX = 2.  
0 < 16 → `render`.

`mov ecx, ecx` zero-extends the already-small step count and is the exit argument. Expected exit: **2**. Leftover `accum` is 0; that leftover is for interpolation, not the status.

```asm
; Listing 09: Fixed-step accumulator loop (LESSON.md block 9)
; Expected exit: 2
; Expected stdout: (none)

.DATA?
accum QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     accum, 32
    xor     rcx, rcx
update_loop:
    cmp     accum, 16
    jl      render
    cmp     rcx, 3
    jge     render
    sub     accum, 16
    inc     rcx
    jmp     update_loop
render:
    mov     ecx, ecx
    call    ExitProcess
main ENDP
END

```

A full frame after this listing still needs a render path and a wait. Windows waits with `Sleep` (milliseconds in RCX), not `nanosleep`.

Listing `13-sleep-frame-pad` is the clamp path of that pad. `FRAME_BUDGET_MS` is 10; `WORK_TARGET_MS` is 12. It stamps `t0` with `GetTickCount64`, then busy-waits until elapsed is `>= 12`. Remaining time is `10 - elapsed`, which is negative, so `jns sleep_positive` fails. The clamp arm zeros RAX, sets `ecx = 1`, and jumps to `do_sleep`.

`do_sleep` then does `mov r8d, edx` / `call Sleep` / `mov ecx, r8d`. On this path EDX was never set (it is a leftover after `GetTickCount64`), and `Sleep` may clobber R8. The header comments Expected exit: **1**, matching the `mov ecx, 1` on the clamp arm, but that 1 is not what `ExitProcess` receives after `do_sleep`. The positive arm would zero EDX and Sleep the remaining milliseconds. This listing has not been assembled with ml64.

```asm
; Listing 13: Sleep frame-budget padding after measured work
; Expected exit: 1
; Expected stdout: (none)
;
; Budget 10 ms; busy-wait until elapsed >= 12 ms; remaining clamps to 0; exit 1.

FRAME_BUDGET_MS EQU 10
WORK_TARGET_MS EQU 12

.DATA?
t0 QWORD ?
t1 QWORD ?

.CODE
EXTRN GetTickCount64:PROC
EXTRN Sleep:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog

    call    GetTickCount64
    mov     t0, rax

work_wait:
    call    GetTickCount64
    mov     t1, rax
    sub     rax, QWORD PTR t0
    cmp     rax, WORK_TARGET_MS
    jl      work_wait

    mov     rbx, rax
    mov     rax, FRAME_BUDGET_MS
    sub     rax, rbx
    jns     sleep_positive
    xor     rax, rax
    mov     ecx, 1
    jmp     do_sleep

sleep_positive:
    mov     ecx, eax
    xor     edx, edx
    jmp     do_sleep

do_sleep:
    mov     r8d, edx
    call    Sleep
    mov     ecx, r8d
    call    ExitProcess
main ENDP
END
```

## Worked example: why listing 08 zeros RDX twice

**Task:** Convert 16000 µs to milliseconds, then divide by a 16 ms step. Listing `08-dt-units-convert` (and listing `10-fixed-step-count`) is that sequence.

**What the instructions do:**

1. `mov rax, 16000` / `xor rdx, rdx` / `mov rbx, 1000` / `div rbx` → RAX = 16, RDX = 0.
2. `xor rdx, rdx` / `mov rbx, 16` / `div rbx` → RAX = 1, RDX = 0.
3. `mov ecx, eax` / `call ExitProcess` → status **1**.

**Plausible wrong reading:**

*"The second `xor rdx, rdx` is redundant. The first one already zeroed RDX, and nothing in between writes to it."*

**Why it's wrong:** `div rbx` **writes RDX**. Unsigned `div` divides `rdx:rax` by the operand, leaves the quotient in RAX and the **remainder** in RDX. For 16000 / 1000 the remainder happens to be 0, so the second `xor` looks like a no-op. Change the input to 16500 µs:

- First `div`: 16500 / 1000 → quotient 16, **remainder 500** in RDX.
- Without the second `xor`, the next `div` divides `(500 · 2⁶⁴ + 16) / 16` — a 128-bit dividend that does not fit a 64-bit quotient, which raises a divide error.

**The correct reading:** Zero RDX immediately before **every** unsigned `div`, because the previous `div` reused RDX for its remainder. Listing 06 needs one `xor`; listings 08 and 10 need two.

## Distinctions worth keeping straight

| Confusion | Reality |
|-----------|---------|
| `clock_gettime` is how you time a Win32 frame | `QueryPerformanceCounter` writes a tick; `QueryPerformanceFrequency` writes ticks per second. Listing `01-qpc-timing` calls both and exits 0 without scaling. |
| dt is a `timespec` (seconds + nanoseconds) | Listing `02-delta-time` is a QWORD subtraction: 142 − 100 = **42**. |
| A hold-repeat is a rising edge | A rising edge is `prev == 0 && cur == 1` (listing `11-rising-edge`, exit **1**). Listing `03-hold-repeat` fires when a **counter** reaches 3 while the key byte stays 1. |
| `neg` the mouse axis unconditionally | Listing `04-mouse-delta-sum` tests `rbx` and only then `neg`. Unconditional `neg` breaks a positive `dy`. |
| `PeekConsoleInputA` blocks like `ReadFile` | It peeks the record buffer without waiting. Listing `05-peek-console-input` imports it, calls only `GetStdHandle(-10)`, and exits **0**. |
| `div` reads only RAX | `div` divides `rdx:rax` and writes **both** RAX (quotient) and RDX (remainder). |
| One `xor rdx, rdx` covers a chain of `div`s | Each `div` writes RDX. Listings 08 and 10 zero it again before the millisecond-to-step `div`. |
| 16000 / 16 is the step count | Convert µs → ms first (÷ 1000), then ÷ 16. Listings 08 and 10 exit **1**, not 1000. |
| Variable dt is deterministic | Fixed 16 ms steps are deterministic. Variable dt tracks the frame rate. |
| The accumulator exit is leftover time | Listing `09-frame-accum-loop` exits the **step count** in ECX (2). Leftover `accum` is 0 and is not the status. |

## Check yourself

1. Listing `08-dt-units-convert` divides 16000 by 1000, then 16 by 16. What is in RDX after the first `div`, and what does the second `div` see if you delete the second `xor rdx, rdx` for an input of 16500 instead of 16000?
2. Listing `09-frame-accum-loop` starts with `accum = 32` and a clamp of 3. How many times does the body run, what is in `accum` at `render`, and which register is the process status?
3. Listing `04-mouse-delta-sum` uses `test rbx, rbx` / `jns pos` before `neg rbx`. Give a `dy` for which skipping that test computes the wrong Manhattan sum with `dx = 5`.
4. Listing `01-qpc-timing` calls `QueryPerformanceFrequency` and `QueryPerformanceCounter`. What does it pass to `ExitProcess`, and which arithmetic is still missing if you want milliseconds?
5. Listing `05-peek-console-input` imports `PeekConsoleInputA`. Which function does it actually call, what is in RCX for that call, and why is the exit 0?

## Key takeaways

- `QueryPerformanceCounter` / `QueryPerformanceFrequency` are imported `kernel32` calls (pointer in RCX, BOOL in RAX). Listing `01-qpc-timing` calls both and exits **0** without computing a delta.
- Delta time is a subtraction of two stamps. Listing `02-delta-time` exits **42** from 142 − 100.
- Hold-repeat fires when a counter reaches a threshold while the key byte stays down (listing `03-hold-repeat`, exit **1**). A rising edge is `prev == 0 && cur == 1` (listing `11-rising-edge`, exit **1**). A chord is two key bytes ANDed (listing `12-two-key-chord`, exit **1**). Mouse Manhattan is `|dx| + |dy|` after a sign test (listing `04-mouse-delta-sum`, exit **7**).
- `GetStdHandle(-10)` is `STD_INPUT_HANDLE`. `PeekConsoleInputA` is the non-blocking peek; listing `05-peek-console-input` declares it and exits **0** without calling it.
- Fixed steps: `xor rdx, rdx` then `div` (listing `06-fixed-step-div` exits **3** from 50 / 16), clamp the quotient (listing `07-timestep-clamp` cuts 6 to **3**), convert units before the step `div` (listings 08 and 10 exit **1**).
- Bank leftover time in an accumulator and spend whole 16 ms steps under a clamp. Listing `09-frame-accum-loop` spends 32 ms as two steps and exits **2**. Listing `13-sleep-frame-pad` is the over-budget clamp (work 12 ms, budget 10 ms); the header says exit **1**, but `do_sleep` passes EDX/`R8` to `ExitProcess` after `Sleep`.

## Lookup

- `QueryPerformanceCounter`: [QueryPerformanceCounter](https://learn.microsoft.com/en-us/windows/win32/api/profileapi/nf-profileapi-queryperformancecounter)
- `QueryPerformanceFrequency`: [QueryPerformanceFrequency](https://learn.microsoft.com/en-us/windows/win32/api/profileapi/nf-profileapi-queryperformancefrequency)
- `GetStdHandle`: [GetStdHandle](https://learn.microsoft.com/en-us/windows/win32/api/processenv/nf-processenv-getstdhandle)
- `PeekConsoleInputA`: [PeekConsoleInputA](https://learn.microsoft.com/en-us/windows/console/peekconsoleinput)
- `Sleep`: [Sleep](https://learn.microsoft.com/en-us/windows/win32/api/synchapi/nf-synchapi-sleep)
- Microsoft x64 calling convention: [x64 calling convention](https://learn.microsoft.com/en-us/cpp/build/x64-calling-convention)
- Fixed timestep: [Gaffer On Games: Fix Your Timestep!](https://gafferongames.com/post/fix_your_timestep/)

## Exercises

Twenty-four drills under `exercises/`. Solutions mirror the names under `solutions/`. Build from an x64 Native Tools Command Prompt:

```bat
ml64 /c FILE.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE FILE.obj kernel32.lib && FILE.exe
echo %ERRORLEVEL%
```

The Jack listings above are the teaching programs. The drill names under `exercises/` (keymap, edge trigger, pause flag, dt accumulator, and the rest) are separate student stubs.
