# Lesson 06 — Strings, Memory, Arrays

Strings are byte sequences with a terminator convention. This lesson implements `strlen` and `strcpy`, distinguishes NUL-terminated walks from counted `memcpy`/`memcmp`/`memset`, uses `rep movsb` only after `cld`, and indexes AoS, SoA, and row-major matrices.

Argument registers are MS x64: first pointer in RCX, second in RDX. `rep movsb` still uses RSI/RDI as implicit pointers — those two are **nonvolatile on Windows**, so a returning procedure that uses them must save/restore them.

## What this lesson asks of you

Scan until byte 0 for length. Copy including the terminator (store then test). Counted copies ignore embedded NULs. `cld` before `rep movsb`. Index records with a stride, matrices with `row * cols + col`.

## Two `strlen` shapes

Count with an index in RAX:

```asm
; Listing 01: String length function
;
; Purpose: Implement strlen - count bytes until null terminator.
; Expected exit code: 11 (length of "Hello world")
; Expected output: (none)
;
; Build: ml64 /c /Fo01-strlen.obj 01-strlen.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-strlen.exe 01-strlen.obj kernel32.lib

.DATA
test_str DB "Hello world", 0

.CODE

EXTRN ExitProcess:PROC

; strlen(str): returns length of null-terminated string
; RCX = pointer to string
; Returns: RAX = length
my_strlen PROC
    xor rax, rax               ; Length = 0
loop_start:
    cmp BYTE PTR [rcx+rax], 0  ; Check for null terminator
    je loop_done
    inc rax
    jmp loop_start
loop_done:
    ret
my_strlen ENDP

main PROC
    sub rsp, 32
    
    lea rcx, test_str
    call my_strlen             ; RAX = 11
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

`"Hello world"` is 11 bytes before NUL. Space counts. The terminator does not.

Walk a pointer, then subtract:

```asm
; Listing 02: strlen implementation (lines 12-25 of LESSON.md)
;
; Purpose: Count bytes until NUL terminator.
; Expected exit code: 5 (length of "hello")
; Expected output: (none)
;
; Build: ml64 /c /Fo02-strlen-implementation.obj 02-strlen-implementation.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-strlen-implementation.exe 02-strlen-implementation.obj kernel32.lib

.DATA
test_str DB "hello", 0

.CODE

EXTRN ExitProcess:PROC

; strlen(RCX) -> RAX
my_strlen PROC
    mov rax, rcx               ; RAX = pointer
scan:
    cmp BYTE PTR [rax], 0      ; Check for NUL
    je done
    inc rax
    jmp scan
done:
    sub rax, rcx               ; Length = end - start
    ret
my_strlen ENDP

main PROC
    sub rsp, 32
    lea rcx, test_str
    call my_strlen
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

Same contract: RCX in, RAX = length 5. Listing 01 never mutates RCX; listing 02 uses RAX as a moving pointer and needs RCX preserved (the callee does not `call` anyone, so RCX stays).

`strchr` is the same scan: compare to the wanted byte, else compare to 0, else increment. Return index or a sentinel. No listing on this branch.

## Worked example: `strcpy` including NUL

**Copy the byte, then test it.** Test-before-copy omits the terminator.

```asm
; Listing 03: strcpy implementation (lines 56-68 of LESSON.md)
;
; Purpose: Copy string including NUL terminator.
; Expected exit code: 0
; Expected output: (none, but dst contains copy)
;
; Build: ml64 /c /Fo03-strcpy-implementation.obj 03-strcpy-implementation.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-strcpy-implementation.exe 03-strcpy-implementation.obj kernel32.lib

.DATA
src DB "test", 0

.DATA?
dst DB 10 DUP(?)

.CODE

EXTRN ExitProcess:PROC

; strcpy(RCX=dst, RDX=src)
my_strcpy PROC
copy_loop:
    mov al, [rdx]              ; Load byte from source
    mov [rcx], al              ; Store to dest (including NUL)
    inc rdx
    inc rcx
    test al, al                ; Was it NUL?
    jnz copy_loop
    ret
my_strcpy ENDP

main PROC
    sub rsp, 32
    lea rcx, dst
    lea rdx, src
    call my_strcpy
    xor ecx, ecx
    call ExitProcess
main ENDP

END
```

RCX = destination, RDX = source (not RDI/RSI). After four ASCII bytes, AL is 0, that 0 is stored, `test al, al` / `jnz` falls through. `dst` is `"test", 0`. Exit 0.

### A plausible wrong reading (and why it fails)

*"Test for NUL first, then copy, so I do not write past the source."*

**Why it fails:** The terminator is never stored. The destination is not a C string. The next `strlen` on `dst` reads uninitialized `.DATA?` bytes until a coincidental zero. Listing 03 stores AL, increments, then tests.

## Counted operations (no listing)

`memcpy`/`memcmp`/`memset` take an explicit count in (typically) R8 as the third argument. They copy, compare, or fill that many bytes, including embedded zeros.

```asm
; memcpy: RCX=dst, RDX=src, R8=count
    xor r9, r9
copy:
    cmp r9, r8
    jge done
    mov al, [rdx+r9]
    mov [rcx+r9], al
    inc r9
    jmp copy
done:
    ret
```

This fragment is not a standalone listing.

## `rep movsb` and Windows RSI/RDI

`movsb` copies `[rsi]` to `[rdi]` and steps both. `rep` repeats RCX times. `cld` first (DF=0, forward).

RSI and RDI are **nonvolatile**. A returning `memcpy` that uses `rep movsb` must `push rsi` / `push rdi` (and unwind codes if FRAME) and pop them before `ret`. Overlapping ranges need a backward copy (`std`) or a different algorithm.

`rep stosb` fills `[rdi]` with AL, RCX times.

## AoS vs SoA vs row-major

AoS: each record's fields adjacent. Point `i` at `base + i * 16` for two qwords.

SoA: `xs[i]` and `ys[i]` as separate arrays, `[xs+rax*8]`.

Row-major: `index = row * cols + col`, then `base + index * sizeof`. For 3×3 qwords, `matrix[1][2]` is index 5, value 6 if filled 1..9.

## Distinctions worth keeping straight

| Confusion | Reality |
|-----------|---------|
| `strlen` includes NUL | It does not. |
| Test then copy | Drops the terminator. Store then test. |
| `memcpy` stops at NUL | It uses a count. |
| Linux `strcpy(rdi, rsi)` | Windows `strcpy(rcx, rdx)`. |
| `rep movsb` clobbers RSI/RDI | Save them; they are callee-saved here. |
| `.DATA?` dst | Uninitialized until you copy. |

## Check yourself

1. Listing 01: what is RAX after scanning `"Hello world"` including the space?
2. Listing 02: why `sub rax, rcx` at `done`?
3. Listing 03: how many stores run for `"test", 0`?
4. Why push RSI/RDI around `rep movsb` on Windows but often not on Linux?
5. Row-major 4×4 DWORDs: address of `(2, 3)` relative to base?

## Key takeaways

- Two equivalent `strlen`s: index vs pointer-difference.
- `strcpy` arguments are RCX/RDX; copy then `test al, al`.
- Counted ops ignore terminators.
- `cld` + `rep movsb`; preserve RSI/RDI.
- Stride math for AoS/SoA/matrices.

## Lookup (reference only, not curriculum)

- Intel SDM: `movsb`, `rep`, `cld`
- MS x64: RSI/RDI nonvolatile

## Exercises

Quoted listings: `01-strlen.asm`, `02-strlen-implementation.asm`, `03-strcpy-implementation.asm`.
