# Lesson 10 — Milestone: CLI Text Editor

Nine lessons of x86-64 and Win32 are now one program: a command-line editor. You keep a byte buffer, a length, and a cursor, insert and delete by shifting the tail, keep free space at the cursor in a gap buffer, find a line start by scanning for `10`, persist a magic-prefixed image with `CreateFileA` / `WriteFile` / `ReadFile` / `CloseHandle`, and put the console into raw mode with `GetConsoleMode` / `SetConsoleMode`. The twenty listings isolate those primitives. The milestone binary composes them.

Every listing is a complete `ml64` program (or, for the editor you build later, several objects linked as in lesson 09). Assemble and link from an x64 Native Tools prompt:

```bat
ml64 /c FILE.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE FILE.obj kernel32.lib && FILE.exe
echo %ERRORLEVEL%
```

## What this lesson asks of you

You keep live text in a byte array with a length and a cursor index clamped to `[0, length]`. You insert by shifting the tail right and delete by shifting it left — memory does not move itself. You keep a gap (`gap_start` … `gap_end`) at the cursor so a typed byte is a store plus an increment, and you move that gap by copying one byte when the cursor moves. You scan backward for byte `10` to find the line start. You set a dirty flag on edit and clear it on save. You write a file image that starts with magic `"ED01"` and an 8-byte length using `CreateFileA` and `WriteFile`, and you reject a bad magic on load. You clear `ENABLE_LINE_INPUT` and `ENABLE_ECHO_INPUT` with `GetConsoleMode` / `SetConsoleMode` so each key arrives without echo, and you restore the original mode before `ExitProcess`.

## Why a text editor as milestone 1

An editor touches lessons 00–09:

- **Memory layout** — `.DATA`, `.DATA?`, buffers
- **Arithmetic and flags** — length checks, cursor clamps, gap subtraction
- **Control flow** — shift loops, scans, edge branches
- **Procedures** — insert, delete, move, render as separate `PROC`s under the Microsoft x64 ABI (lesson 04)
- **Strings and arrays** — byte buffers, NUL-terminated paths
- **Bitwise operations** — console-mode masks (lesson 07)
- **Win32 API** — `GetStdHandle`, `ReadFile`, `WriteFile`, `CreateFileA`, `CloseHandle`, `GetConsoleMode`, `SetConsoleMode` (lessons 00 and 08)
- **Macros and multi-file** — `MACRO`, `EXTRN`, `PUBLIC`, NMake (lesson 09)

The milestone is a capstone binary. The listings are testbenches for one primitive at a time. You do not start by writing 500 lines.

## Buffer, cursor, length

Editor state is three values: the bytes, how many are live, and where the cursor sits. Listings `01`–`04` name them `buffer`, `buf_len`, and `cursor`. Listings `05`–`08` and `20` name them `buf`, `len`, and `cur`. Same roles.

An empty buffer has length 0 and cursor 0. Appending writes at the live end and increments `buf_len` (or `len`). The cursor may be any index in `[0, buf_len]`, including `buf_len` (past the last live byte). Insert at the end is an append. Insert in the middle shifts the tail.

Indexed stores do not use `buffer[rax]` / `buf[rcx]` as a memory operand. Each of those listings does `lea r10, buffer` (or `lea r10, buf`) once, then addresses `[r10+rax]`, `[r10+rcx]`, and so on. That is RIP-relative: `lea` materializes the buffer address, then the index is a register offset.

### Append

Listing `01-buffer-append` starts empty, appends `'A'`, `'B'`, then `'C'`, and exits with the length. After `lea r10, buffer`, each append is `mov rax, buf_len` / `mov BYTE PTR [r10+rax], …` / `inc buf_len`. The cursor is initialized to 0 and never moved. `mov ecx, DWORD PTR buf_len` takes the low 32 bits for `ExitProcess`. Expected exit: **3**.

```asm
; 01-buffer-append.asm
;
; Purpose: Demonstrate buffer append operation
; Expected exit code: 3
; Expected stdout: (none)
;
; Core buffer primitive: append byte to end

.DATA?
buffer DB 256 DUP(?)
buf_len QWORD ?
cursor QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     r10, buffer
    ; Initialize empty buffer
    mov     buf_len, 0
    mov     cursor, 0
    
    ; Append 'A'
    mov     rax, buf_len
    mov     BYTE PTR [r10+rax], 'A'
    inc     buf_len
    
    ; Append 'B'
    mov     rax, buf_len
    mov     BYTE PTR [r10+rax], 'B'
    inc     buf_len
    
    ; Append 'C'
    mov     rax, buf_len
    mov     BYTE PTR [r10+rax], 'C'
    inc     buf_len
    
    ; Exit with buf_len (3)
    mov     ecx, DWORD PTR buf_len
    call    ExitProcess
main ENDP

END
```

### Append and advance the cursor

Listing `05-append-advance-cursor` appends one `'A'` and increments both `len` and `cur`. The process status is the new length. Expected exit: **1**.

```asm
; Listing 05: Append byte and advance cursor (LESSON.md block 5)
;
; Purpose: Append 'A' at end and move cursor with length.
; Expected exit code: 1
; Expected stdout: (none)

.DATA?
buf BYTE 4096 DUP(?)
len QWORD ?
cur QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     r10, buf
    mov     len, 0
    mov     cur, 0
    mov     rax, len
    mov     BYTE PTR [r10+rax], 'A'
    inc     len
    inc     cur
    mov     ecx, DWORD PTR len
    call    ExitProcess
main ENDP

END
```

### Cursor clamp

Moving right increments the cursor only when it is less than length. Moving left decrements only when it is greater than 0. A cursor past length or wrapped below 0 is memory corruption. Use unsigned compares (`jae`, `jbe`) on indices.

Listing `04-cursor-clamp` sets `buf_len` to 3 and `cursor` to 9, then `cmp rax, buf_len` / `jbe cursor_ok`. 9 is above 3, so it stores 3 back into `cursor`. Expected exit: **3**.

A corrupted cursor of `0FFFFFFFFFFFFFFFFh` (all bits 1) is **greater** than 3 as unsigned, so `jbe` fails and the clamp still stores 3. A signed `jle` would treat that value as −1, which is less than 3, and would skip the clamp.

```asm
; 04-cursor-clamp.asm
;
; Purpose: Demonstrate cursor clamping to valid range [0, buf_len]
; Expected exit code: 3
; Expected stdout: (none)
;
; Clamps out-of-range cursor to [0, buf_len]

.DATA?
buffer DB 256 DUP(?)
buf_len QWORD ?
cursor QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    ; Setup: buffer with buf_len 3
    mov     buf_len, 3
    
    ; Simulate corrupted cursor (cursor = 9, out of range)
    mov     cursor, 9
    
    ; Clamp cursor to [0, buf_len]
    mov     rax, cursor
    cmp     rax, buf_len
    jbe     cursor_ok
    mov     rax, buf_len
    mov     cursor, rax
    
cursor_ok:
    ; Cursor now clamped to 3
    ; Exit with clamped cursor value
    mov     ecx, DWORD PTR cursor
    call    ExitProcess
main ENDP

END
```

### Backspace at the end

When the cursor equals the length, backspace is two decrements: drop the last byte and pull the cursor back. Listing `06-backspace-at-end` starts with `'X'`, `len = 1`, `cur = 1`. It refuses to run if `cur` is 0, then checks `cur == len`, then `dec len` / `dec cur`. Expected exit: **0** (the new length). A backspace in the middle needs the delete-forward tail shift below.

```asm
; Listing 06: Backspace when cursor at end (LESSON.md block 6)
;
; Purpose: Decrement len and cur when cur == len at end of buffer.
; Expected exit code: 0
; Expected stdout: (none)

.DATA?
buf BYTE 4096 DUP(?)
len QWORD ?
cur QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     r10, buf
    mov     BYTE PTR [r10+0], 'X'
    mov     len, 1
    mov     cur, 1
    cmp     cur, 0
    je      done
    mov     rax, cur
    cmp     rax, len
    jne     done
    dec     len
    dec     cur
done:
    mov     ecx, DWORD PTR len
    call    ExitProcess
main ENDP

END
```

## Inserting and deleting in the middle: tail shifts

When the cursor is not at the end, insert and delete **shift the tail**.

### Insert in the middle

To insert `'B'` at index 1 in `"AC"` (length 2), producing `"ABC"`:

1. Shift `buf[1..len)` one byte rightward to `buf[2..len+1)`.
2. Store `'B'` at `buf[1]`.
3. Increment `len`.
4. Increment `cur` if the cursor should sit after the new byte.

The shift walks `rcx` from `len` downward. Copy `buf[rcx-1]` to `buf[rcx]`. Stop before you copy the byte at the cursor (that slot is about to become the new character).

Listing `02-insert-middle` uses `jle shift_done` — the loop continues while `rcx > cursor`. After `lea r10, buffer`, from `rcx = 2` and `cursor = 1` that is one copy: `[r10+2] = [r10+1]` (`'C'`). Then it stores `'B'` at `[r10+cursor]`, increments `buf_len` and `cursor`, and exits with the immediate 66 (`'B'`). Final buffer `"ABC"`. Expected exit: **66**.

```asm
; 02-insert-middle.asm
;
; Purpose: Insert character in middle of buffer with tail shift
; Expected exit code: 66 (ASCII 'B')
; Expected stdout: (none)
;
; Demonstrates: Shifting tail rightward to make room for insertion

.DATA?
buffer DB 256 DUP(?)
buf_len QWORD ?
cursor QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     r10, buffer
    ; Setup: "AC" with cursor at 1
    mov     BYTE PTR [r10+0], 'A'
    mov     BYTE PTR [r10+1], 'C'
    mov     buf_len, 2
    mov     cursor, 1
    
    ; Insert 'B' at cursor (index 1)
    ; Shift tail rightward
    mov     rcx, buf_len
shift_loop:
    cmp     rcx, cursor
    jle     shift_done
    mov     al, BYTE PTR [r10+rcx-1]
    mov     BYTE PTR [r10+rcx], al
    dec     rcx
    jmp     shift_loop
    
shift_done:
    ; Store new byte at cursor
    mov     rax, cursor
    mov     BYTE PTR [r10+rax], 'B'
    inc     buf_len
    inc     cursor
    
    ; Buffer now contains "ABC"
    ; Exit with 'B' (66)
    mov     ecx, 66
    call    ExitProcess
main ENDP

END
```

Listing `07-insert-middle-shift` is the same algorithm on `buf` / `len` / `cur` with `jle done_shift`. Same exit: **66**.

```asm
; Listing 07: Insert in middle with tail shift (LESSON.md block 7)
;
; Purpose: Shift tail right and insert 'B' at cursor.
; Expected exit code: 66
; Expected stdout: (none)

.DATA?
buf BYTE 4096 DUP(?)
len QWORD ?
cur QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     r10, buf
    mov     BYTE PTR [r10+0], 'A'
    mov     BYTE PTR [r10+1], 'C'
    mov     len, 2
    mov     cur, 1
    mov     rcx, len
shift:
    cmp     rcx, cur
    jle     done_shift
    mov     al, BYTE PTR [r10+rcx-1]
    mov     BYTE PTR [r10+rcx], al
    dec     rcx
    jmp     shift
done_shift:
    mov     rax, cur
    mov     BYTE PTR [r10+rax], 'B'
    inc     len
    inc     cur
    mov     ecx, 66
    call    ExitProcess
main ENDP

END
```

`jle` is signed. Indices in these listings stay small and non-negative, so it matches `jbe`. Listing `20-insert-shift-jl` uses `jl` instead; that extra iteration is the worked example.

### Delete-forward

Delete-forward removes the byte at the cursor and slides `buf[cur+1..len)` left onto `buf[cur..len-1)`.

Listing `03-delete-forward` starts with `"ABC"` (`buf_len` 3), cursor at 1 (the `'B'`). After `lea r10, buffer`, the loop increments RCX from the cursor, copies `[r10+rcx]` to `[r10+rcx-1]`, and stops when `rcx >= buf_len`. Then `dec buf_len`. The buffer is `"AC"`, length 2. Expected exit: **2**.

That is not `"ABCD"` and not exit 3. Three live bytes, one deletion, status 2.

```asm
; 03-delete-forward.asm
;
; Purpose: Delete character at cursor (shift tail leftward)
; Expected exit code: 2
; Expected stdout: (none)
;
; Demonstrates: Delete-forward operation with tail shift

.DATA?
buffer DB 256 DUP(?)
buf_len QWORD ?
cursor QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     r10, buffer
    ; Setup: "ABC" with cursor at 1
    mov     BYTE PTR [r10+0], 'A'
    mov     BYTE PTR [r10+1], 'B'
    mov     BYTE PTR [r10+2], 'C'
    mov     buf_len, 3
    mov     cursor, 1
    
    ; Delete byte at cursor (delete 'B')
    ; Shift tail leftward
    mov     rcx, cursor
shift_loop:
    inc     rcx
    cmp     rcx, buf_len
    jge     shift_done
    mov     al, BYTE PTR [r10+rcx]
    mov     BYTE PTR [r10+rcx-1], al
    jmp     shift_loop
    
shift_done:
    dec     buf_len
    ; Buffer now contains "AC" (buf_len 2)
    
    ; Exit with buf_len (2)
    mov     ecx, DWORD PTR buf_len
    call    ExitProcess
main ENDP

END
```

Listing `08-delete-forward-shift` repeats the same `"ABC"` / cursor 1 / `jge done_shift` pattern on `buf` / `len` / `cur`. Expected exit: **2**.

```asm
; Listing 08: Delete-forward tail shift (LESSON.md block 8)
;
; Purpose: Shift [r10+cur+1..len) left and decrement len.
; Expected exit code: 2
; Expected stdout: (none)

.DATA?
buf BYTE 4096 DUP(?)
len QWORD ?
cur QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     r10, buf
    mov     BYTE PTR [r10+0], 'A'
    mov     BYTE PTR [r10+1], 'B'
    mov     BYTE PTR [r10+2], 'C'
    mov     len, 3
    mov     cur, 1
    mov     rcx, cur
shift:
    inc     rcx
    cmp     rcx, len
    jge     done_shift
    mov     al, BYTE PTR [r10+rcx]
    mov     BYTE PTR [r10+rcx-1], al
    jmp     shift
done_shift:
    dec     len
    mov     ecx, DWORD PTR len
    call    ExitProcess
main ENDP

END
```

## The gap buffer: amortizing tail shifts

Shifting a 10 KB tail on every keystroke is the cost you are avoiding. A **gap buffer** keeps the unused capacity at the cursor. An insert at the gap is a store and an increment. You pay a copy only when the cursor (and therefore the gap) moves.

Live text is `buf[0..gap_start)` on the left and `buf[gap_end..capacity)` on the right. Free space is `gap_end - gap_start`.

Listing `09-gap-buffer-fields` declares `buf BYTE 4096 DUP(?)`, `gap_start`, and `gap_end`, sets them to 0 and 4096, and exits 0. That is an empty buffer: every byte is gap.

```asm
; Listing 09: Gap buffer layout (LESSON.md block 9)
;
; Purpose: Declare gap buffer with gap_start and gap_end pointers.
; Expected exit code: 0
; Expected stdout: (none)

.DATA?
buf BYTE 4096 DUP(?)
gap_start QWORD ?
gap_end QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     gap_start, 0
    mov     gap_end, 4096
    xor     ecx, ecx
    call    ExitProcess
main ENDP

END

```

Listing `10-gap-empty-init` computes `gap_end - gap_start` (4096) and passes that value to `ExitProcess` in ECX. The harness compares the full 32-bit status. Expected exit: **4096**.

```asm
; Listing 10: Empty gap buffer (LESSON.md block 10)
;
; Purpose: Initialize empty gap; free space = gap_end - gap_start.
; Expected exit: 4096
; Expected stdout: (none)

.DATA?
buf BYTE 4096 DUP(?)
gap_start QWORD ?
gap_end QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     gap_start, 0
    mov     gap_end, 4096
    mov     rax, gap_end
    sub     rax, gap_start
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
```

### Insert at the gap

Listing `11-gap-insert-byte` starts at `gap_start = 2`, `gap_end = 6` (4 free bytes). It stores `'X'` at `buf[gap_start]`, increments `gap_start` to 3, then exits with the remaining free space `6 - 3`. The store is real — this listing writes the byte. Expected exit: **3**.

```asm
; Listing 11: Insert at gap_start (LESSON.md block 11)
;
; Purpose: Store at gap_start and advance; exit remaining free bytes.
; Expected exit code: 3
; Expected stdout: (none)

.DATA?
buf BYTE 4096 DUP(?)
gap_start QWORD ?
gap_end QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     r10, buf
    mov     gap_start, 2
    mov     gap_end, 6
    mov     rax, gap_start
    mov     BYTE PTR [r10+rax], 'X'
    inc     gap_start
    mov     rax, gap_end
    sub     rax, gap_start
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
```

### Moving the gap left

Cursor left means the gap slides left one byte: copy `buf[gap_start-1]` to `buf[gap_end-1]`, then decrement both bounds.

Listing `12-gap-move-left` plants `'Q'` at `buf[2]`, sets `gap_start = 3` and `gap_end = 5`, then:

1. `mov rax, gap_start` / `dec rax` — RAX is the source index 2.
2. `mov r8, rax` keeps that index. After `lea r10, buf`, `movzx edx, BYTE PTR [r10+r8]` loads `'Q'` without clobbering the index.
3. `mov rcx, gap_end` / `dec rcx` — RCX is 4. `mov BYTE PTR [r10+rcx], dl` writes `'Q'` to `buf[4]`.
4. `mov gap_start, r8` stores 2. `mov gap_end, rcx` stores 4. `mov ecx, 2` is the process status.

Expected exit: **2**. A `mov al, BYTE PTR [r10+rax]` here would have overwritten the index with `'Q'` (81). The listing uses `r8` / `movzx edx` so that does not happen.

```asm
; Listing 12: Move gap left one byte (LESSON.md block 12)
;
; Purpose: Copy byte left of gap into gap from the right side.
; Expected exit code: 2
; Expected stdout: (none)

.DATA?
buf BYTE 4096 DUP(?)
gap_start QWORD ?
gap_end QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     r10, buf
    mov     BYTE PTR [r10+2], 'Q'
    mov     gap_start, 3
    mov     gap_end, 5
    mov     rax, gap_start
    dec     rax
    mov     r8, rax                 ; index 2 (do not clobber with AL load)
    movzx   edx, BYTE PTR [r10+r8]
    mov     rcx, gap_end
    dec     rcx
    mov     BYTE PTR [r10+rcx], dl
    mov     gap_start, r8
    mov     gap_end, rcx
    mov     ecx, 2                  ; gap_start after move
    call    ExitProcess
main ENDP

END
```

To keep the index, copy the byte into a register that is not holding the index (`movzx edx, BYTE PTR [r10+rax]` after `dec rax`, or save the decremented index in another register before loading AL).

### Moving the gap right

Cursor right copies `buf[gap_end]` onto `buf[gap_start]` and increments both bounds. Listing `13-gap-move-right` plants `'Z'` at `buf[5]`, starts at `gap_start = 2` and `gap_end = 5`, does that copy (AL is overwritten the same way, but the listing reloads `gap_end` afterward), then exits with remaining free space `6 - 3`. Expected exit: **3**.

```asm
; Listing 13: Move gap right one byte (LESSON.md block 13)
;
; Purpose: Copy byte at gap_end into gap_start and advance gap.
; Expected exit code: 3
; Expected stdout: (none)

.DATA?
buf BYTE 4096 DUP(?)
gap_start QWORD ?
gap_end QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     r10, buf
    mov     BYTE PTR [r10+5], 'Z'
    mov     gap_start, 2
    mov     gap_end, 5
    mov     rax, gap_end
    mov     al, BYTE PTR [r10+rax]
    mov     rcx, gap_start
    mov     BYTE PTR [r10+rcx], al
    inc     gap_start
    inc     gap_end
    mov     rax, gap_end
    sub     rax, gap_start
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
```

Typing at a fixed gap is O(1) until the gap is empty. Moving the cursor is one byte copy per position.

## Lines: scanning and kill-line

A line is the text between newline bytes (`10`). Windows files often use CR LF (`13, 10`); the scan in this listing looks for `10`. The **line start** is the index after the previous `10`, or 0 if there is none.

Listing `14-line-start-scan` uses `.DATA` bytes `"ab", 10, "cd", 0` — indices `0='a'`, `1='b'`, `2=10`, `3='c'`, `4='d'`. RSI is the cursor 4. The scan decrements RCX until it sees `10` or hits 0, then `inc rcx` to step past the newline. RCX is 3. `mov ecx, ecx` is a no-op; `ExitProcess` takes that 3. Expected exit: **3**.

```asm
; Listing 14: Scan backward for line start (LESSON.md block 14)
;
; Purpose: Find line start index for cursor in buffer with newlines.
; Expected exit code: 3
; Expected stdout: (none)

.DATA
buf BYTE "ab", 10, "cd", 0

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     r10, buf
    mov     rsi, 4
    mov     rcx, rsi
scan:
    test    rcx, rcx
    jz      done
    dec     rcx
    cmp     BYTE PTR [r10+rcx], 10
    jne     scan
    inc     rcx
done:
    mov     ecx, ecx
    call    ExitProcess
main ENDP

END
```

**Kill-line** deletes from the cursor through the last character before the newline and **leaves the newline**.

Listing `21-kill-line` uses the same `"ab", 10, "cd"` bytes as listing 14, with `len = 5` and `cur = 0` (the cursor field is written and never read). The scan starts at index 0 and walks forward until `buf[rcx] == 10`. That newline is at index 2. Then it copies `buf[2..5)` down to `buf[0..)`: the three bytes `10`, `'c'`, `'d'`. `len` becomes the destination count 3. Expected exit: **3**. After the copy the buffer is `"\ncd"` plus the leftover terminator; the newline stayed. The prologue is `push rdi` / `push rsi` / `sub rsp, 40` (two nonvolatile saves plus a 40-byte frame; RSP ≡ 8 at the `call`).

The drill `exercises/24-from-scratch-kill-line.asm` is still the from-scratch version.

```asm
; Listing 21: Kill-line deletes to newline, keeps newline (LESSON.md)
; Expected exit: 3
; Expected stdout: (none)

.DATA
buf BYTE "ab", 10, "cd", 0

.DATA?
len QWORD ?
cur QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    push    rdi
    push    rsi
    sub     rsp, 40
    mov     len, 5
    mov     cur, 0

    mov     rcx, 0
    lea     rdx, buf
find_nl:
    cmp     BYTE PTR [rdx + rcx], 10
    je      found_nl
    inc     rcx
    jmp     find_nl

found_nl:
    mov     r8, rcx
    mov     r9, len
    mov     rdi, 0
    mov     rsi, r8
copy_rest:
    cmp     rsi, r9
    jge     copy_done
    movzx   eax, BYTE PTR [rdx + rsi]
    mov     BYTE PTR [rdx + rdi], al
    inc     rsi
    inc     rdi
    jmp     copy_rest

copy_done:
    mov     len, rdi
    mov     ecx, DWORD PTR len
    call    ExitProcess
main ENDP
END
```

## Rendering the buffer

The smallest render is `WriteFile` of the live bytes to standard output. Listing `15-render-buffer` writes `"ed"` plus CR LF (`13, 10`). `len EQU $ - buf` is 4. The frame is `main PROC FRAME` / `sub rsp, 56` / `.allocstack 56`. `GetStdHandle` is called with RCX = −11, then `WriteFile` uses `lea rdx, buf`, `mov r8d, len`, `lea r9, written`, and a NULL overlapped QWORD at `[rsp+32]`. Expected exit: **0**. Expected stdout: `ed` and a CRLF.

There is no `syscall` and no `nasm` `section .bss` in this listing. Console output is `GetStdHandle` + `WriteFile`, as in lesson 00.

```asm
; Listing 15: Write buffer to stdout (LESSON.md block 15)
;
; Purpose: Write live buffer bytes with WriteFile to stdout.
; Expected exit code: 0
; Expected stdout: "ed\r\n"

.DATA
buf BYTE "ed", 13, 10
len EQU $ - buf

.DATA?
written DWORD ?

.CODE
EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog

    mov     rcx, -11
    call    GetStdHandle
    mov     rcx, rax
    lea     rdx, buf
    mov     r8d, len
    lea     r9, written
    mov     QWORD PTR [rsp+32], 0
    call    WriteFile

    xor     ecx, ecx
    call    ExitProcess
main ENDP

END
```

A full-screen editor writes a viewport — a window of lines around the cursor — not necessarily the whole buffer. The listing is the write primitive, not the viewport math.

## Save, load, dirty flag, and magic numbers

A save file needs a way to reject garbage. These listings use a 4-byte magic `"ED01"` and an 8-byte length.

### Dirty flag

Any edit sets the flag; a successful save clears it. Listing `16-dirty-flag` stores 1, then stores 0, then `movzx ecx, BYTE PTR dirty` so the status is the cleared flag. Expected exit: **0**.

```asm
; Listing 16: Dirty flag on edit, clear on save (LESSON.md block 16)
;
; Purpose: Set dirty on edit and clear after mock save.
; Expected exit code: 0
; Expected stdout: (none)

.DATA?
dirty BYTE ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     BYTE PTR dirty, 1
    mov     BYTE PTR dirty, 0
    movzx   ecx, BYTE PTR dirty
    call    ExitProcess
main ENDP

END

```

### File layout and save

```
Offset  Size  Field
0       4     Magic "ED01" ('E','D','0','1' = 45h, 44h, 30h, 31h)
4       8     Length (QWORD)
12      N     Buffer bytes (omitted when N is 0)
```

Little-endian, the first two magic bytes as a word are `4445h` (low byte `'E'` = 45h, next byte `'D'` = 44h).

Listing `17-save-length-prefix` creates or truncates `editor.save` with `CreateFileA`:

| Argument | Register / slot | Value in the listing |
|----------|-----------------|----------------------|
| path | RCX | `lea rcx, path` |
| access | EDX | `40000000h` (`GENERIC_WRITE`) |
| share | R8D | 0 |
| security | R9D | 0 |
| disposition | `[rsp+32]` | 2 (`CREATE_ALWAYS`) |
| attributes | `[rsp+40]` | `80h` (`FILE_ATTRIBUTE_NORMAL`) |
| template | `[rsp+48]` | 0 |

`cmp rax, -1` / `je fail` rejects `INVALID_HANDLE_VALUE`. The HANDLE is saved in RBX. Two `WriteFile` calls write 4 magic bytes and the 8-byte `len` (the listing initializes `len QWORD 0`). There is no third `WriteFile` for buffer contents. `CloseHandle`, then `xor ecx, ecx` / `call ExitProcess`. Failure exits 1.

Frame: `push rbx` / `.pushreg rbx` / `sub rsp, 64` / `.allocstack 64`. Expected exit on success: **0**. Side effect: `editor.save` holds 12 bytes (`ED01` plus eight `00h` bytes).

```asm
; Listing 17: Save editor image with Win32 I/O (LESSON.md block 17)
;
; Purpose: CreateFileA/WriteFile/CloseHandle write magic, length, and buffer.
; Expected exit code: 0
; Expected stdout: (none)

.DATA
path DB "editor.save", 0
magic DB "ED01"
len QWORD 0

.DATA?
bytesWritten DWORD ?
hFile QWORD ?

.CODE
EXTRN CreateFileA:PROC
EXTRN WriteFile:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    sub     rsp, 64
    .allocstack 64
    .endprolog

    lea     rcx, path
    mov     edx, 40000000h
    xor     r8d, r8d
    xor     r9d, r9d
    mov     DWORD PTR [rsp+32], 2
    mov     DWORD PTR [rsp+40], 80h
    mov     QWORD PTR [rsp+48], 0
    call    CreateFileA
    cmp     rax, -1
    je      fail
    mov     rbx, rax

    mov     rcx, rbx
    lea     rdx, magic
    mov     r8d, 4
    lea     r9, bytesWritten
    mov     QWORD PTR [rsp+32], 0
    call    WriteFile

    mov     rcx, rbx
    lea     rdx, len
    mov     r8d, 8
    lea     r9, bytesWritten
    mov     QWORD PTR [rsp+32], 0
    call    WriteFile

    mov     rcx, rbx
    call    CloseHandle

    xor     ecx, ecx
    call    ExitProcess

fail:
    mov     ecx, 1
    call    ExitProcess
main ENDP

END

```

### Load and magic check

Listing `18-load-validate-magic` does not call `CreateFileA` or `ReadFile`. It compares `WORD PTR magic` to `4445h`. On match it sets ECX = 1; on mismatch it clears ECX. The drill exits **1** when the prefix is `"ED"` — inverted from a real editor, which would accept a good magic and reject a bad one.

```asm
; Listing 18: Load and validate magic (LESSON.md block 18)
;
; Purpose: Compare magic word; exit 1 on "ED" prefix match (drill semantics).
; Expected exit code: 1
; Expected stdout: (none)

.DATA
magic DB "ED01", 0

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    cmp     WORD PTR magic, 4445h
    jne     bad_magic
    mov     ecx, 1
    jmp     done
bad_magic:
    xor     ecx, ecx
done:
    call    ExitProcess
main ENDP

END

```

A production load opens the path (`OPEN_EXISTING` = 3, `GENERIC_READ` = `80000000h`), `ReadFile`s 4 + 8 bytes, compares the word to `4445h`, then `ReadFile`s `len` bytes into the buffer, then `CloseHandle`. Lesson 08 is the API contract.

## Raw mode: capturing keypresses

A console starts in canonical mode: `ReadFile` on stdin waits for Enter and echoes. An editor needs **raw mode**: each key arrives immediately, with no echo.

Console mode is a `DWORD` bitmask from `GetConsoleMode` / `SetConsoleMode`. Two input bits matter here:

| Flag | Value | Meaning |
|------|------:|---------|
| `ENABLE_PROCESSED_INPUT` | 1 | Process Ctrl+C |
| `ENABLE_LINE_INPUT` | 2 | Line-buffered input |
| `ENABLE_ECHO_INPUT` | 4 | Echo input |
| `ENABLE_WINDOW_INPUT` | 8 | Window events |
| `ENABLE_MOUSE_INPUT` | 10h | Mouse events |

Raw mode clears bits 2 and 4. `2 OR 4` is 6. Listing `19-raw-console-mode` writes that as `and eax, NOT 6`.

The listing:

1. `GetStdHandle` with RCX = −10 (`STD_INPUT_HANDLE`), stores the HANDLE in `stdin_handle`.
2. `GetConsoleMode(stdin_handle, &original_mode)`. FALSE (`test eax, eax` / `jz`) exits 1.
3. `and eax, NOT 6`, store in `mode`, `SetConsoleMode(stdin_handle, mode)`. FALSE exits 1.
4. Restores `original_mode` with a second `SetConsoleMode`.
5. `xor ecx, ecx` / `call ExitProcess`.

Frame: `sub rsp, 56` / `.allocstack 56`. Expected exit on success: **0**. Forget the restore and the console stays raw after the process dies — no echo, no line editing — until the user opens a new console.

```asm
; Listing 19: Raw console mode via Get/SetConsoleMode (LESSON.md block 19)
;
; Purpose: Clear ENABLE_LINE_INPUT and ENABLE_ECHO_INPUT, then restore mode.
; Expected exit code: 0
; Expected stdout: (none)

.DATA?
mode DWORD ?
original_mode DWORD ?
stdin_handle QWORD ?

.CODE
EXTRN GetStdHandle:PROC
EXTRN GetConsoleMode:PROC
EXTRN SetConsoleMode:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog

    mov     rcx, -10
    call    GetStdHandle
    mov     stdin_handle, rax

    mov     rcx, stdin_handle
    lea     rdx, original_mode
    call    GetConsoleMode
    test    eax, eax
    jz      no_console

    mov     eax, original_mode
    and     eax, NOT 6
    mov     mode, eax

    mov     rcx, stdin_handle
    mov     edx, mode
    call    SetConsoleMode
    test    eax, eax
    jz      error_exit

    mov     rcx, stdin_handle
    mov     edx, original_mode
    call    SetConsoleMode

    xor     ecx, ecx
    call    ExitProcess

no_console:
    xor     ecx, ecx
    call    ExitProcess

error_exit:
    mov     ecx, 1
    call    ExitProcess
main ENDP

END
```

## Worked example: how far does the tail shift under `jl`?

**Task:** Buffer `"AC"` (length 2), cursor at 1, insert `'B'`. Listing `20-insert-shift-jl` uses `jl put_byte` as the shift exit test and stores `'B'` at the literal `buf[1]`. What does the loop do, and what is the process status?

**The loop:**

- `rcx` starts at `len` (2).
- `cmp rcx, cur` (1). `jl` fires only when RCX < 1.
- Otherwise copy `buf[rcx-1]` to `buf[rcx]`, decrement RCX, jump back.

**Trace:**

| Iteration | RCX | `cmp rcx, cur` | Action | Buffer |
|-----------|----:|----------------|--------|--------|
| 1 | 2 | 2 ≥ 1, not less | `buf[2] = buf[1]` (`'C'`) | `A C C` |
| 2 | 1 | 1 ≥ 1, not less | `buf[1] = buf[0]` (`'A'`) | `A A C` |
| 3 | 0 | 0 < 1, `jl` | — | `A A C` |
| — | — | — | `buf[1] = 'B'`, `inc len` | `A B C` |

`mov ecx, DWORD PTR len` then `call ExitProcess`. Expected exit: **3**.

Listings `02-insert-middle` and `07-insert-middle-shift` use `jle` / `jle done_shift` and stop when `rcx == cur`. They copy `'C'` once, then store `'B'` at `buf[cur]`. Listing `20` copies one extra slot (`buf[0]` onto `buf[1]`) and then overwrites that slot with `'B'`. The extra copy is wasted work, not a wrong final buffer.

```asm
; Listing 20: Insert-middle shift with jl exit test (LESSON.md block 20)
;
; Purpose: Shift loop using jl; store 'B' at index 1; len becomes 3.
; Expected exit code: 3
; Expected stdout: (none)

.DATA?
buf BYTE 4096 DUP(?)
len QWORD ?
cur QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     r10, buf
    mov     BYTE PTR [r10+0], 'A'
    mov     BYTE PTR [r10+1], 'C'
    mov     len, 2
    mov     cur, 1
    mov     rcx, len
shift:
    cmp     rcx, cur
    jl      put_byte
    mov     al, BYTE PTR [r10+rcx-1]
    mov     BYTE PTR [r10+rcx], al
    dec     rcx
    jmp     shift
put_byte:
    mov     BYTE PTR [r10+1], 'B'
    inc     len
    mov     ecx, DWORD PTR len
    call    ExitProcess
main ENDP

END
```

### A plausible wrong reading (and why it fails)

*"The loop moves every tail byte one place right, so it runs once — just the `'C'` — and stops."*

The exit test is `jl` (jump if less), so the body runs while `rcx >= cur`. It stops only at RCX = 0. The second iteration overwrites `buf[1]` with `'A'` before `put_byte` stores `'B'` at the literal `[buf+1]`. That store is not `buf[cur]`; the listing is correct only because `cur` happens to be 1. A real insert writes `buf[cur]` (as listings `02` and `07` do) and increments `cur`. Changing `jl` to `jle` (or unsigned `jbe`) drops the wasted copy.

## Distinctions worth keeping straight

| Confusion | Reality |
|-----------|---------|
| `len` is the capacity | `len` / `buf_len` is live bytes. Capacity is the `DUP` size (256 in listings `01`–`04`, 4096 in the `buf` listings) |
| The cursor is a pointer | It is an index. Address the buffer with `lea r10, buf` then `[r10+rax]`, not `buf[rax]` and not a raw pointer in a register |
| Insert moves the tail by itself | You shift `buf[cur..len)` right, then store. Listings `02`, `07`, and `20` |
| Delete-forward on `"ABCD"` exits 3 | Listings `03` and `08` start with `"ABC"`, delete `'B'`, and exit **2** |
| Gap buffer removes every copy | Inserts **at the gap** are a store. Cursor motion still copies (listings `12`, `13`) |
| Listing `11` only does arithmetic | It stores `'X'` at `buf[gap_start]` before incrementing |
| Listing `10` exits 4096 | `ExitProcess` gets 4096 in ECX; the harness compares that full 32-bit status |
| Kill-line deletes the newline | Kill-line deletes **up to** the newline; the newline stays. No Jack listing; the drill is exercise 24 |
| Save writes a computed 12 and exits 12 | Listing `17-save-length-prefix` writes magic + length with `CreateFileA` / `WriteFile` and exits **0** |
| Magic word is `4544h` | Little-endian `"ED"` as a word is `4445h` (listing `18-load-validate-magic`) |
| Raw mode is the default | You clear bits with `and eax, NOT 6` and you restore `original_mode` (listing `19-raw-console-mode`) |
| Linux `syscall` / `nasm` `section .bss` | These listings call `GetStdHandle`, `WriteFile`, `CreateFileA`, `GetConsoleMode`, `SetConsoleMode`, `ExitProcess` |

## Check yourself

1. Listing `03-delete-forward` starts with `"ABC"`, cursor 1. After the shift and `dec buf_len`, what three bytes sit in `buffer[0..2]`, and what is the process status?
2. Listing `20-insert-shift-jl` uses `jl`; listings `02` and `07` use `jle`. Starting at `"AC"` / cursor 1, how many byte copies does each loop perform before the store of `'B'`?
3. Listing `04-cursor-clamp` uses `jbe`. If a bug set `cursor` to `0FFFFFFFFFFFFFFFFh` with `buf_len = 3`, would the clamp write 3? Would a signed `jle` write 3?
4. Listing `11-gap-insert-byte` starts at `gap_start = 2`, `gap_end = 6`. After the store and increment, what is `gap_start`, what is the remaining free space, and what byte is in `buf[2]`?
5. Listing `19-raw-console-mode` does `and eax, NOT 6`. If `original_mode` were `0000001Fh`, what 32-bit value is written to `mode`? Why does the listing call `SetConsoleMode` a second time with `original_mode`?

## Key takeaways

- An editor is a byte buffer plus a length and a cursor in `[0, length]`. Listing `01-buffer-append` exits 3 after three appends; listing `04-cursor-clamp` pulls a cursor of 9 back to 3.
- Insert in the middle copies the tail rightward, then stores. `jle` stops at the cursor (listings `02`, `07`, exit 66). `jl` copies one extra slot (listing `20`, exit 3).
- Delete-forward copies the tail left. Listings `03` and `08` turn `"ABC"` into `"AC"` and exit 2.
- A gap buffer stores at `gap_start` (listing `11` writes `'X'` and exits 3 remaining). Moving the gap copies one byte (listings `12`, `13`). Listing `10` computes 4096 free bytes and exits **4096**.
- Line start is a backward scan for `10` (listing `14` exits 3 on `"ab", 10, "cd"` at cursor 4). Kill-line leaves the newline: listing `21-kill-line` copies `"\ncd"` down and exits **3**.
- Save is `CreateFileA` + `WriteFile` of `"ED01"` and an 8-byte length (listing `17` exits 0). Load checks `WORD PTR magic` against `4445h` (listing `18` exits 1 on a match).
- Raw mode is `GetConsoleMode`, `and eax, NOT 6`, `SetConsoleMode`, then a restore (listing `19` exits 0).

## Lookup

- Console mode: [GetConsoleMode](https://learn.microsoft.com/en-us/windows/console/getconsolemode), [SetConsoleMode](https://learn.microsoft.com/en-us/windows/console/setconsolemode), [Console Modes](https://learn.microsoft.com/en-us/windows/console/console-modes)
- File API (lesson 08): [CreateFileA](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-createfilea), [WriteFile](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-writefile), [ReadFile](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-readfile), [CloseHandle](https://learn.microsoft.com/en-us/windows/win32/api/handleapi/nf-handleapi-closehandle)
- Standard handles: [GetStdHandle](https://learn.microsoft.com/en-us/windows/console/getstdhandle)
- Gap buffer: [Wikipedia: Gap buffer](https://en.wikipedia.org/wiki/Gap_buffer)
- Virtual terminal sequences (cursor positioning; not in these listings): [Console Virtual Terminal Sequences](https://learn.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences)

## Acceptance criteria

The milestone binary is complete when all six hold:

1. **Open, edit, quit.** Opens a text file or starts empty, displays it, accepts keypresses, quits on a defined key (for example Ctrl+Q) without dropping the buffer.
2. **Cursor discipline.** The cursor never leaves `[0, len]`. Every move and edit applies the clamp from listing `04-cursor-clamp`.
3. **Kill-line semantics.** Kill-line removes text from the cursor to the end of the line and leaves the newline, per `exercises/24-from-scratch-kill-line.asm`.
4. **Save/load integrity.** Save writes `"ED01"` and a length prefix with `CreateFileA` and `WriteFile` (listing `17-save-length-prefix`). A bad magic is rejected.
5. **Dirty flag.** Any edit sets the flag; only a successful save clears it (listing `16-dirty-flag`). Quit with unsaved changes warns.
6. **Viewport rendering.** The editor writes the buffer with `WriteFile` to the HANDLE from `GetStdHandle` (listing `15-render-buffer`). No C runtime. Factor rendering, buffer ops, and I/O with lesson 09's multi-file `ml64` / `link` (NMake or PowerShell).

Listing `19-raw-console-mode` is what makes criterion 1's keypresses arrive without waiting for Enter.

## Exercises

Twenty-four drills under `exercises/`. Solutions mirror the names under `solutions/`. Build from an x64 Native Tools Command Prompt:

```bat
ml64 /c FILE.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE FILE.obj kernel32.lib && FILE.exe
```

The exercises use MASM and the Win32 APIs from lessons 00–09.

**Buffer basics:** empty buffer, exit 0. Append `'A'`, exit 1. Move right then left, exit 0. Backspace at end (decrement `len`). Insert `'X'` in an empty buffer, cursor becomes 1. Insert `'B'` into `"AC"`, exit 66. Delete from a short buffer, new length in the status. Five single-byte cursor steps, exit 5 (no UTF-8 decode). Clamp `cur = 9` with `len = 3`, exit 3.

**Gap buffer:** empty gap arithmetic. One insert at `gap_start`, store a byte, increment, exit `gap_start` or remaining free space. Move the gap left one byte.

**Line operations:** `WriteFile` of a short line plus CRLF, exit 0. Line-start scan from a cursor past a `10`. Viewport write of the first bytes. Kill-line from cursor 0 in `"ab", 10, "cd"`, new length 3.

**File and state:** save stub, exit 0. Load stub sets a length. Dirty set then clear, exit 0. Length-prefix image via `CreateFileA` / `WriteFile`. Magic word `4445h`. Undo-stack push/pop arithmetic. A byte flag cleared to model `ENABLE_LINE_INPUT` (the raw-mode listing above calls `SetConsoleMode` for real).

Expected exits are in each file header under `exercises/` — all 494 exercise `.asm` files on this tree carry one. There is no `exercises/10-milestone-cli-editor/README.md`.