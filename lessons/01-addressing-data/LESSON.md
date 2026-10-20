# Lesson 01 — Addressing Modes & Data Sections

Most computation happens in registers, but real programs read and write memory. This lesson teaches you how to declare data in the right MASM section, how to address it with immediate values, labels, register indirection, and scaled indexing, and crucially how to distinguish between computing an address (`lea`) and loading the value stored at that address (`mov`). Once you master these addressing modes, you can implement arrays, buffers, and structured data layouts.

## What this lesson asks of you

You must be able to choose the correct MASM section (`.data`, `.const`, `.data?`, `.code`) for initialized mutable data, read-only constants, zero-filled buffers, and executable code. You will use all the major addressing modes: immediate (constants), register-to-register, direct memory access via labels, register-indirect `[reg]`, base+displacement `[reg+offset]`, and full scaled-index-base `[base+index*scale+disp]`. You will also recognize that `lea` performs address arithmetic without touching memory, while `mov` with brackets loads or stores actual data. By the end, you should be able to index into an array, read and write buffers of different sizes (`BYTE`, `WORD`, `DWORD`, `QWORD`), and debug common mistakes like wrong sizes or uninitialized reads.

## PE/COFF sections: where your data lives

A PE (Portable Executable) binary divides memory into **sections**, each with different permissions and purposes. The linker and loader use these sections to decide what gets mapped as read-only, read-write, or executable. In MASM, you use directives to declare which section you are currently defining; the assembler maps these directives to PE section names.

| MASM Directive | PE Section | Purpose | Permission | File bytes? |
|----------------|------------|---------|------------|-------------|
| `.code` | `.text` | Executable code (instructions) | Read + execute | Yes |
| `.data` | `.data` | Initialized read-write data | Read + write | Yes |
| `.const` | `.rdata` | Read-only initialized data (constants, strings) | Read only | Yes |
| `.data?` | `.data` (uninitialized) | Uninitialized or zero-filled data | Read + write | No (size in headers) |

Use `.const` for string literals you never modify, like prompts or error messages. Use `.data` for variables you initialize and later change, like counters or status flags. Use `.data?` for buffers and large arrays that start at zero — the loader zeros `.data?` at load time, so the object file does not waste space storing zeros. Use `.code` for your instructions.

Here's how they look in practice:

<!-- LISTING-PENDING: lessons/01-addressing-data/listings/section-declarations.asm -->

```asm
.const
    prompt BYTE "Enter value: ", 0    ; null-terminated string (immutable)

.data
    counter QWORD 0                   ; 8-byte initialized counter

.data?
    buffer BYTE 256 DUP(?)            ; 256-byte zero-filled buffer

.code
main PROC
    ; code goes here
    ret
main ENDP
END
```

The difference between `BYTE` (or `db`) and `BYTE N DUP(?)` is that `BYTE` with values stores actual byte values in the object file, while `BYTE N DUP(?)` in `.data?` only reserves space without storing anything — the loader fills it with zeros. MASM accepts lowercase synonyms (`db`, `dw`, `dd`, `dq`) from other assemblers, but the uppercase `BYTE`, `WORD`, `DWORD`, `QWORD` are more idiomatic in MASM and match the Win32 API type names.

## Addressing modes: how to name memory locations

An **addressing mode** specifies where the operand lives: in a register, at a fixed address, at an address computed from registers, or as an immediate constant. x86-64 supports a rich set of modes.

### Immediate and register modes

```asm
mov rax, 42          ; immediate: rax = 42 (constant)
mov rbx, rax         ; register: rbx = rax (copy register)
```

Nothing touches memory here.

### Direct (label) addressing

```asm
mov rax, [counter]   ; load 8 bytes from address 'counter' into rax
mov [counter], rax   ; store rax into memory at address 'counter'
```

The label `counter` is a symbol resolved by the linker to a fixed address. Brackets mean "load from" or "store to" that address. Without brackets, `mov rax, counter` would load the *address* of `counter` as an immediate, not its contents.

### Register-indirect addressing

```asm
mov al, [rsi]        ; load 1 byte from the address in rsi into al
mov [rdi], al        ; store al to the address in rdi
```

The address is whatever value `rsi` or `rdi` currently holds. This is how you walk through buffers: increment `rsi` after each read to move to the next byte.

### Base + displacement

```asm
mov eax, [rbx+8]     ; load 4 bytes from address (rbx + 8) into eax
mov qword [rsp-16], rax   ; store rax at address (rsp - 16)
```

Useful for accessing struct fields at fixed offsets: if `rbx` points to the start of a struct, `[rbx+8]` accesses the field at offset 8. Also used for stack locals relative to `rsp` or `rbp`.

### Scaled index (array indexing)

```asm
mov al, [rsi+rcx]           ; address = rsi + rcx (1-byte elements)
mov rax, [rbx+rcx*8]        ; address = rbx + rcx*8 (8-byte elements)
mov eax, [rbx+rcx*4+16]     ; address = rbx + rcx*4 + 16 (full SIB form)
```

This is the hardware support for array indexing. If `rbx` points to the start of an array of 8-byte elements and `rcx` holds the index, then `[rbx+rcx*8]` accesses `array[rcx]` directly. The **scale** can be 1, 2, 4, or 8, matching common element sizes. The full **SIB (Scale-Index-Base)** form combines a base register, an index register, a scale, and a constant displacement.

### Size specifiers

When the instruction does not imply the operand size, you must specify it explicitly. MASM uses the `PTR` keyword with a size specifier:

```asm
mov BYTE PTR [buffer], 65       ; store 1 byte (ASCII 'A')
mov WORD PTR [buffer], 4241h    ; store 2 bytes (hex literal in MASM uses 'h' suffix)
mov DWORD PTR [buffer], 1       ; store 4 bytes
mov QWORD PTR [buffer], rax     ; store 8 bytes
```

Without the size specifier, `mov [buffer], 65` is ambiguous — does it store a byte, a word, a doubleword, or a quadword? MASM will reject it with an error. When the destination is a register, the size is clear from the register name (`al` = 1 byte, `eax` = 4 bytes, `rax` = 8 bytes), so no `PTR` is needed.

**Note:** MASM also accepts the NASM-style syntax `mov byte [buffer], 65` without `PTR`, but the `BYTE PTR` form is more idiomatic and explicit in MASM code. This course uses the `PTR` form for clarity.

## Load effective address: `lea` vs `mov`

The `lea` instruction computes an address expression and stores the **result address** in a register, without accessing memory. In contrast, `mov` with brackets accesses memory at that address.

```asm
lea rax, [rbx+rcx*4+8]      ; rax = rbx + rcx*4 + 8 (no memory access)
mov rax, [rbx+rcx*4+8]      ; rax = qword loaded from address (rbx + rcx*4 + 8)
```

Why is `lea` useful? It lets you do integer arithmetic in one instruction. For example, `lea rax, [rax+rax*2]` computes `rax = rax * 3` without a multiply instruction. It also computes the address of an array element without dereferencing it:

```asm
lea rdi, [buffer+rsi]       ; rdi = address of buffer[rsi]
```

Now `rdi` points to that element, but you have not loaded its value. You might pass this address to a function or use it later.

A common mistake is to write `lea rax, [rbx]` thinking it does something special — it simply copies `rbx` to `rax`, equivalent to `mov rax, rbx`, and is pointless. Use `lea` when you actually need address arithmetic.

Another distinction: in NASM, you write `lea rdi, [rel msg]` to request RIP-relative addressing (needed for position-independent code). In MASM 64-bit mode, **RIP-relative addressing is the default** for symbol references like `[msg]`, so you write simply `lea rdi, msg` or `lea rdi, [msg]` (the brackets are optional for `lea` with a bare symbol). If you want the address of `msg` as an immediate constant (not RIP-relative), you use `mov rsi, OFFSET msg` — but this is rare in 64-bit code. For this course, `lea` with a symbol generates RIP-relative addressing automatically, and you do not need to specify anything special.

## Worked example: indexing into an array and summing elements

Let's write a program that declares an array of quadwords, iterates over it, and sums the values. Here is the source:

<!-- LISTING-PENDING: lessons/01-addressing-data/listings/sum-array.asm -->

```asm
EXTERN ExitProcess:PROC

.data
    arr QWORD 10, 20, 30, 40       ; array of four 64-bit values
    arr_len EQU ($ - arr) / 8      ; number of elements (32 bytes / 8)

.code
main PROC
    sub rsp, 40                    ; allocate shadow space + alignment
    
    xor rax, rax                   ; rax will hold the sum (start at 0)
    xor rcx, rcx                   ; rcx is the loop index (start at 0)

loop_start:
    cmp rcx, arr_len               ; compare index to length
    jge loop_done                  ; if index >= length, exit loop

    add rax, [arr+rcx*8]           ; add arr[rcx] to the sum
    inc rcx                        ; increment index
    jmp loop_start                 ; repeat

loop_done:
    mov ecx, eax                   ; exit status = sum (low 32 bits, should be 100)
    call ExitProcess
    ; ExitProcess does not return
main ENDP
END
```

Build and run:
```cmd
ml64 /c sum_array.asm
link /OUT:sum_array.exe /ENTRY:main /SUBSYSTEM:CONSOLE sum_array.obj kernel32.lib
sum_array.exe
echo %ERRORLEVEL%   REM should print 100
```

Trace the reasoning. In `.data`, we declare `arr` with four quadwords (10, 20, 30, 40). The expression `($ - arr) / 8` computes the number of elements: `$` is the current address after the array, so `$ - arr` is 32 bytes, and dividing by 8 (the size of each element) gives 4.

We allocate 40 bytes on the stack (32 bytes shadow space + 8 for alignment) before any calls. In the loop, `rcx` starts at 0. We compare `rcx` to `arr_len` and jump to `loop_done` if the index is out of bounds. (Note: MASM labels inside a `PROC` are local to that procedure unless you use `@@:` anonymous labels or explicitly declare them global. We use descriptive names like `loop_start` and `loop_done` for clarity.)

Inside the loop body, `add rax, [arr+rcx*8]` uses **scaled-index addressing**: the address is `arr + rcx*8`, which is the address of `arr[rcx]`. MASM generates RIP-relative addressing for `arr` automatically in 64-bit mode. The square brackets load the quadword at that address, and `add` adds it to `rax`. After incrementing `rcx`, we jump back to `loop_start`. When `rcx` reaches 4, the comparison fails and we jump to `loop_done`, where we move the sum (100) into ECX (the low 32 bits; writing ECX zero-extends into RCX) and call `ExitProcess`. The process terminates with exit code 100.

### A plausible wrong reading (and why it fails)

A common mistake is to write `add rax, [arr+rcx]` (scale 1 instead of scale 8). The intent is to access `arr[rcx]`, but without the correct scale, the address is only `arr + rcx` — if `rcx` is 0, this accesses `arr[0]` correctly (by luck, since offset 0 is offset 0 regardless of scale), but if `rcx` is 1, it accesses the byte at offset 1, which is in the middle of the first quadword. The CPU will load 8 bytes starting from that misaligned address, reading parts of two elements and producing nonsense. On the second iteration, you get a garbage value (likely the high bytes of 10 and the low bytes of 20 concatenated as one misaligned quadword), and the sum is wrong.

The lesson: the **scale** must match the element size. For an array of quadwords (8 bytes each), use `*8`. For an array of doublewords (4 bytes), use `*4`. For an array of words (2 bytes), use `*2`. For byte arrays, use `*1` or omit the scale (they are equivalent). Failing to match the scale is the most common indexing error and produces subtle bugs that only appear when the index is nonzero.

## Distinctions worth keeping straight

| Confusion | What actually separates them |
|-----------|------------------------------|
| `.data` vs `.const` | Both hold initialized data, but `.data` is writable (maps to PE `.data` section) and `.const` is read-only (maps to PE `.rdata` section). Attempting to write to `.const` causes an access violation (exception). Use `.const` for string literals and constants you never modify. |
| `.data?` vs `.data` | `.data?` is zero-filled at load and occupies no file bytes; `.data` stores actual bytes in the object file. Use `.data?` for large buffers that start at zero to save disk space. |
| `BYTE value` vs `BYTE N DUP(?)` | The first defines bytes with initial values; the second only reserves space (for `.data?`). You use `BYTE N DUP(?)` in `.data?` to reserve uninitialized space, and `BYTE value` in `.data` or `.const` to store actual bytes. |
| `mov rax, [label]` vs `mov rax, OFFSET label` | The first loads the value stored at `label` (RIP-relative addressing in 64-bit mode); the second loads the *address* of `label` as an immediate constant. In 64-bit MASM, you rarely need `OFFSET` because RIP-relative addressing is automatic. |
| `lea rax, [rbx+8]` vs `mov rax, [rbx+8]` | `lea` computes `rbx+8` and stores that address in `rax` without touching memory. `mov` loads the quadword at address `rbx+8` into `rax`. If `rbx` is uninitialized, `mov` will crash or read garbage; `lea` will just compute garbage+8, which may or may not cause a later error. |
| `mov [buffer], 42` vs `mov BYTE PTR [buffer], 42` | The first is ambiguous and MASM rejects it with an error. You must specify `BYTE PTR`, `WORD PTR`, `DWORD PTR`, or `QWORD PTR` when the size is not implied by a register operand. |
| Scale `*1` vs `*2` vs `*4` vs `*8` | The scale must match the element size in bytes. Arrays of quadwords need `*8`, arrays of doublewords need `*4`, arrays of words need `*2`, and byte arrays need `*1` (or no scale). Using the wrong scale produces misaligned access and wrong data. |
| RIP-relative addressing (automatic in MASM 64-bit) | In NASM, you write `[rel symbol]` to request RIP-relative addressing. In MASM 64-bit mode, `[symbol]` automatically generates RIP-relative addressing — you do not need to specify it. This is the default and correct behavior for position-independent x64 code. |

## Check yourself

1. You declare a string in `.const` and try to modify it at runtime with `mov BYTE PTR [str], 65`. What happens, and why?
2. An array of doublewords (4-byte integers) starts at label `nums`. You want to load `nums[3]` into `eax`. Write the instruction using scaled-index addressing.
3. Explain the difference between `lea rsi, [buffer+10]` and `mov rsi, [buffer+10]`. What does each instruction put in `rsi`, and does either touch memory at address `buffer+10`?
4. You declare `counter QWORD 1 DUP(?)` in `.data?` but then try to use it before initializing it. The program runs but produces garbage values. What did you forget, and how should you initialize it at runtime?
5. Trace the value of `rax` after each iteration of the worked example above. What is `rax` after the first iteration (when `rcx=1`)? After the second (when `rcx=2`)? After the third (when `rcx=3`)? After the fourth iteration completes (when `rcx=4`, just before jumping to `loop_done`)?

## Key takeaways

- MASM sections (`.code`, `.data`, `.const`, `.data?`) map to PE sections (`.text`, `.data`, `.rdata`, `.data` uninitialized) and separate code, mutable data, immutable constants, and zero-filled buffers, each with different permissions and file representation.
- Brackets `[]` mean "load from" or "store to" memory at the computed address; without brackets, a label with `OFFSET` is an immediate address constant (but in 64-bit MASM, RIP-relative addressing is automatic, so you rarely use `OFFSET`).
- Scaled-index addressing `[base+index*scale+disp]` is hardware support for array indexing — the scale must match the element size or you will access wrong offsets.
- `lea` computes an address expression and stores the result in a register without accessing memory; `mov` with brackets actually loads or stores data.
- Size specifiers (`BYTE PTR`, `WORD PTR`, `DWORD PTR`, `QWORD PTR`) are mandatory when the operand size is ambiguous — MASM will reject ambiguous stores with an error.
- Writing to `.const` causes a runtime access violation (exception) because the loader maps it read-only; attempting to execute `.data` or `.data?` will also fault.

## Lookup (reference only, not curriculum)

- **MASM addressing syntax:** https://learn.microsoft.com/en-us/cpp/assembler/masm/masm-for-x64-ml64-exe (effective addresses, PTR operators, size specifiers)
- **PE section attributes:** https://learn.microsoft.com/en-us/windows/win32/debug/pe-format (section headers, flags, permissions)
- **x86-64 addressing modes:** Intel® 64 and IA-32 Architectures Software Developer's Manual, Volume 1, Chapter 3.7 (operand addressing) — same as Linux; addressing modes are platform-independent
- **MASM data directives:** https://learn.microsoft.com/en-us/cpp/assembler/masm/directives-reference (`BYTE`, `WORD`, `DWORD`, `QWORD`, `DUP`)
- **Tool inspection:** `dumpbin /headers <file>` (show PE section headers), `dumpbin /disasm <file>` (disassemble)

## Exercises

28 drills: declarations, loads/stores, LEA, indexing, bug hunts, stretch buffer work.
