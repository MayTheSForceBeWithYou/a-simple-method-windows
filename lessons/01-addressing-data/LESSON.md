# Lesson 01 — Addressing Modes & Data Sections

Most computation happens in registers, but real programs read and write memory. This lesson teaches you how to declare data in the right MASM section, how to address it with labels, register indirection, displacement, and scaled indexing, and how to distinguish computing an address (`lea`) from loading the value stored there (`mov`). Once you master these addressing modes, you can implement arrays, buffers, and structured data layouts.

## What this lesson asks of you

You must choose the correct MASM section (`.DATA`, `.CONST`, `.DATA?`, `.CODE`) for initialized mutable data, read-only constants, zero-filled buffers, and executable code. You will use immediate, register, direct-label, register-indirect `[reg]`, base+displacement `[reg+offset]`, and scaled-index `[base+index*scale]` addressing. You will recognize that `lea` performs address arithmetic without touching memory, while `mov` with a memory operand loads or stores data. By the end you should index into an array, read and write `BYTE`/`WORD`/`DWORD`/`QWORD` buffers, and debug wrong scales and uninitialized reads.

## PE/COFF sections: where your data lives

| MASM directive | PE section | Purpose | Permission | File bytes? |
|----------------|------------|---------|------------|-------------|
| `.CODE` | `.text` | Instructions | Read + execute | Yes |
| `.DATA` | `.data` | Initialized read-write data | Read + write | Yes |
| `.CONST` | `.rdata` | Read-only initialized data | Read only | Yes |
| `.DATA?` | uninitialized `.data` / `.bss` | Zero-filled at load | Read + write | Size in headers only |

Use `.CONST` for strings you never modify. Use `.DATA` for initialized variables you later change. Use `.DATA?` for buffers that start at zero — the loader zeros them, so the object file does not store the zeros. Use `.CODE` for instructions.

64-bit MASM encodes accesses to these labels as **RIP-relative** by default. You do not write NASM's `[rel symbol]`.

```asm
; Listing 01: Data section declarations
;
; Purpose: Demonstrates different data sections and their uses.
; Expected exit code: 42
; Expected output: (none)
;
; Build: ml64 /c /Fo01-data-sections.obj 01-data-sections.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-data-sections.exe 01-data-sections.obj kernel32.lib

.CONST
readonly_msg DB "This is read-only", 0

.DATA
counter DQ 42                  ; Initialized, writable 64-bit value
status DD 0                    ; Initialized 32-bit value

.DATA?
buffer DB 256 DUP(?)           ; Uninitialized 256-byte buffer

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    ; Load counter value and exit with it
    mov rax, counter           ; Load from .DATA
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

`DB`/`DQ`/`DD` are the same sizes as `BYTE`/`QWORD`/`DWORD`. `256 DUP(?)` reserves 256 uninitialized bytes. `mov rax, counter` in MASM loads the **contents** of `counter` (42). That is the opposite of NASM, where `mov rax, counter` is an address immediate and you need `mov rax, [counter]` for the value. In MASM, `mov rax, OFFSET counter` or `lea rax, counter` produces the address.

## Addressing modes

### Immediate and register

```asm
mov rax, 42          ; immediate
mov rbx, rax         ; register copy
```

Nothing touches memory.

### Direct (label) addressing

MASM treats a bare data label as a memory operand. Brackets are optional for that case:

```asm
mov rax, value1      ; load 8 bytes from label value1
mov result, rax      ; store rax at label result
```

```asm
; Listing 02: Direct addressing with labels
;
; Purpose: Load from and store to memory using label addresses.
; Expected exit code: 30
; Expected output: (none)
;
; Build: ml64 /c /Fo02-direct-addressing.obj 02-direct-addressing.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-direct-addressing.exe 02-direct-addressing.obj kernel32.lib

.DATA
value1 DQ 10
value2 DQ 20
result DQ 0

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    ; Load values from memory
    mov rax, value1            ; RAX = 10
    mov rbx, value2            ; RBX = 20
    
    ; Compute sum
    add rax, rbx               ; RAX = 30
    
    ; Store result to memory
    mov result, rax            ; Store 30 to result
    
    ; Exit with result
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

### Register-indirect addressing

`lea` puts an address in a register. `[rsi]` then loads through that pointer. `BYTE PTR` is required when the register does not imply size (`movzx` source).

```asm
; Listing 03: Register-indirect addressing
;
; Purpose: Access memory through pointer registers.
; Expected exit code: 72 (ASCII 'H')
; Expected output: (none)
;
; Build: ml64 /c /Fo03-register-indirect.obj 03-register-indirect.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-register-indirect.exe 03-register-indirect.obj kernel32.lib

.DATA
msg DB "Hello", 0

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    ; Load address of msg into RSI
    lea rsi, msg
    
    ; Load first byte through register-indirect addressing
    movzx rcx, BYTE PTR [rsi]  ; RCX = 'H' (72)
    
    call ExitProcess
main ENDP

END
```

RSI is nonvolatile. This `main` never returns, so it does not save RSI. A returning procedure that uses RSI must push/pop it.

### Base + displacement

A record is a base address plus fixed field offsets. Age at 0, height at 8, weight at 16:

```asm
; Listing 04: Base + displacement addressing
;
; Purpose: Access struct-like fields at fixed offsets.
; Expected exit code: 42
; Expected output: (none)
;
; Build: ml64 /c /Fo04-base-displacement.obj 04-base-displacement.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-base-displacement.exe 04-base-displacement.obj kernel32.lib

.DATA
person_record:
    DQ 42                      ; Offset 0: age
    DQ 180                     ; Offset 8: height_cm
    DQ 75                      ; Offset 16: weight_kg

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    ; Load base address
    lea rbx, person_record
    
    ; Access fields with displacement
    mov rax, [rbx+0]           ; age (42)
    mov rdx, [rbx+8]           ; height (180)
    mov r8, [rbx+16]           ; weight (75)
    
    ; Exit with age
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

After `lea rbx, person_record`: `[rbx+0]` is 42, `[rbx+8]` is 180, `[rbx+16]` is 75. Exit status is 42.

### Scaled index (array indexing)

Scale must match element size. Quadwords use `*8`.

```asm
; Listing 05: Scaled-index addressing for arrays
;
; Purpose: Demonstrate array indexing with proper scaling.
; Expected exit code: 30 (arr[2])
; Expected output: (none)
;
; Build: ml64 /c /Fo05-array-indexing.obj 05-array-indexing.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:05-array-indexing.exe 05-array-indexing.obj kernel32.lib

.DATA
arr DQ 10, 20, 30, 40, 50     ; Array of 5 quadwords (8 bytes each)
arr_len EQU ($ - arr) / 8

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    ; Load base address
    lea rbx, arr
    
    ; Access arr[2] using scaled index
    mov rcx, 2                 ; Index 2
    mov rax, [rbx+rcx*8]       ; Scale by 8 for quadwords
                               ; RAX = 30
    
    ; Exit with arr[2]
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

`arr_len EQU ($ - arr) / 8` is 5. Index 2 × 8 = offset 16, which is 30.

### Size specifiers

When the instruction does not imply size, MASM requires `PTR`:

```asm
; Listing 08: Size specifiers - byte, word, dword, qword
;
; Purpose: Demonstrate explicit size specifications for memory operands.
; Expected exit code: 65 (ASCII 'A')
; Expected output: (none)
;
; Build: ml64 /c /Fo08-size-specifiers.obj 08-size-specifiers.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:08-size-specifiers.exe 08-size-specifiers.obj kernel32.lib

.DATA?
buffer DB 64 DUP(?)

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    lea rbx, buffer
    
    ; Store different sizes
    mov BYTE PTR [rbx], 65     ; Store 1 byte: 'A'
    mov WORD PTR [rbx+1], 0x4342  ; Store 2 bytes: 'BC'
    mov DWORD PTR [rbx+3], 12345678 ; Store 4 bytes
    mov QWORD PTR [rbx+7], -1  ; Store 8 bytes
    
    ; Load and exit with first byte
    movzx rcx, BYTE PTR [rbx]
    call ExitProcess
main ENDP

END
```

`mov [rbx], 65` is ambiguous; MASM errors. `mov BYTE PTR [rbx], 65` stores one byte. Little-endian: `WORD PTR [rbx+1], 0x4342` stores `42h` then `43h` (`'B'`, `'C'`). `movzx rcx, BYTE PTR [rbx]` zero-extends `'A'` (65) into RCX for `ExitProcess`.

## `lea` vs `mov`

`lea` stores the **address**. `mov` with a memory operand stores the **value**.

```asm
; Listing 06: LEA vs MOV - computing addresses vs loading values
;
; Purpose: Show the crucial difference between LEA and MOV with memory operands.
; Expected exit code: 20
; Expected output: (none)
;
; Build: ml64 /c /Fo06-lea-vs-mov.obj 06-lea-vs-mov.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:06-lea-vs-mov.exe 06-lea-vs-mov.obj kernel32.lib

.DATA
value DQ 20

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    ; LEA: compute address, no memory access
    lea rax, value             ; RAX = address of value
    
    ; MOV: load value from memory
    mov rbx, value             ; RBX = 20 (loaded from memory)
    
    ; LEA with arithmetic: multiply by 3
    mov rcx, 5
    lea rdx, [rcx+rcx*2]       ; RDX = rcx + rcx*2 = 5 + 10 = 15
    
    ; Exit with the value (20)
    mov rcx, rbx
    call ExitProcess
main ENDP

END
```

After `lea rax, value`, RAX is a pointer (some high canonical user address), not 20. After `mov rbx, value`, RBX is 20. `lea rdx, [rcx+rcx*2]` computes 5×3 = 15 in the address unit; no load occurs. Exit uses RBX (20), not RAX (the address) and not RDX (15).

NASM `lea rdi, [rel msg]` maps to MASM `lea rdi, msg`. `mov rsi, OFFSET msg` is an absolute immediate and is rare in 64-bit code.

## Worked example: summing an array

```asm
; Listing 07: Complete array summing example
;
; Purpose: Iterate over array, sum all elements.
; Expected exit code: 100 (10+20+30+40)
; Expected output: (none)
;
; Build: ml64 /c /Fo07-array-sum.obj 07-array-sum.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:07-array-sum.exe 07-array-sum.obj kernel32.lib

.DATA
arr DQ 10, 20, 30, 40
arr_len EQU ($ - arr) / 8

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    xor rax, rax               ; Sum = 0
    xor rcx, rcx               ; Index = 0
    lea rbx, arr               ; Base address
    
loop_start:
    cmp rcx, arr_len
    jge loop_done
    
    add rax, [rbx+rcx*8]       ; sum += arr[index]
    inc rcx
    jmp loop_start
    
loop_done:
    mov rcx, rax               ; Exit with sum (100)
    call ExitProcess
main ENDP

END
```

Build (from the listings directory, x64 Native Tools Command Prompt):

```bat
ml64 /c /Fo07-array-sum.obj 07-array-sum.asm
link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:07-array-sum.exe 07-array-sum.obj kernel32.lib
07-array-sum.exe
echo %ERRORLEVEL%
```

`arr_len` is 4. Loop:

| After iteration | RCX (next index) | RAX (sum) |
|-----------------|------------------|-----------|
| 1 | 1 | 10 |
| 2 | 2 | 30 |
| 3 | 3 | 60 |
| 4 | 4 | 100 |

Then `cmp rcx, arr_len` (`4 >= 4`) takes `jge loop_done`. Exit 100.

Labels inside a `PROC` are local to that procedure. `sub rsp, 32` is shadow space for `ExitProcess`.

### A plausible wrong reading (and why it fails)

*"I can write `add rax, [rbx+rcx]` because RCX is the index."*

**Why it fails:** Without `*8`, index 1 addresses byte offset 1, in the middle of the first quadword. The load is a misaligned 8-byte mix of 10 and 20. Scale must match element size: QWORD `*8`, DWORD `*4`, WORD `*2`, BYTE `*1` or omit scale.

A second NASM-shaped mistake: treating `mov rax, counter` as "load address." In MASM that instruction loads the value. Use `lea` or `OFFSET` for the address.

## Distinctions worth keeping straight

| Confusion | Reality |
|-----------|---------|
| `.DATA` vs `.CONST` | Both initialized; `.CONST` is read-only (`.rdata`). A store there access-violates. |
| `.DATA?` vs `.DATA` | `.DATA?` is zeroed at load and stores no file bytes. |
| `mov rax, counter` (MASM) vs NASM | MASM loads **contents**. NASM without brackets loads the **address**. |
| `lea rax, value` vs `mov rax, value` | `lea` = address, no load. `mov` = load the QWORD. |
| `mov [buf], 42` vs `mov BYTE PTR [buf], 42` | Ambiguous store is an assemble error. |
| Scale | Must match element size in bytes. |
| RIP-relative | Default in 64-bit MASM; no `rel` keyword. |

## Check yourself

1. You put a string in `.CONST` and execute `mov BYTE PTR [str], 65`. What happens?
2. Array of DWORDs at `nums`. Load `nums[3]` into EAX with scaled-index addressing.
3. After listing `06-lea-vs-mov`, what is in RAX versus RBX versus RDX just before `mov rcx, rbx`?
4. `counter DQ ?` in `.DATA?` is used before a store. What value should you expect?
5. In listing `07-array-sum`, what is RAX after the iteration that consumed `arr[2]` (30)?

## Key takeaways

- `.CODE` / `.DATA` / `.CONST` / `.DATA?` map to PE `.text` / `.data` / `.rdata` / uninitialized storage.
- In MASM, a bare data label in `mov` is a memory operand (contents), not an address immediate.
- Scaled-index scale must match element size.
- `lea` computes an address; `mov` with a memory operand accesses memory.
- `BYTE PTR` / `WORD PTR` / `DWORD PTR` / `QWORD PTR` are required when size is ambiguous.
- Writes to `.CONST` fault.

## Lookup (reference only, not curriculum)

- MASM for x64: https://learn.microsoft.com/en-us/cpp/assembler/masm/masm-for-x64-ml64-exe
- PE sections: https://learn.microsoft.com/en-us/windows/win32/debug/pe-format
- Intel SDM Volume 1, operand addressing
- MASM data directives: https://learn.microsoft.com/en-us/cpp/assembler/masm/directives-reference

## Exercises

Work in `exercises/`. Standalone listings quoted above are `lessons/01-addressing-data/listings/01-data-sections.asm` through `08-size-specifiers.asm`.
