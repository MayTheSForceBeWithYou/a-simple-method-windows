# Lesson 00 — Tools, Registers, `mov`, Win32 API Calls

Assembly is not an opaque ritual. This lesson makes the toolchain cycle concrete: you type instructions in a text file, `ml64.exe` translates them to machine code, `link.exe` packages the result as a Windows PE executable, and your CPU runs it. Once you understand how data moves between registers and how to request operating system services via the Win32 API, you can write programs that do real work. By the end of this lesson, you will build executables from scratch, name every general-purpose register, call Win32 API functions to print text and exit cleanly, and understand why Windows uses function calls where Linux uses the `syscall` instruction.

## What this lesson asks of you

You must be able to assemble and link a freestanding x86-64 PE executable using `ml64.exe` and `link.exe /ENTRY:main /SUBSYSTEM:CONSOLE`, write a program that calls Win32 API functions (`GetStdHandle`, `WriteFile` or `WriteConsoleA`, and `ExitProcess`) to print text and terminate, and name the general-purpose registers and their size variants (64/32/16/8-bit). You will also distinguish between `mov` (data transfer) and `xor reg, reg` (the idiomatic zero), understand the Microsoft x64 calling convention (first four arguments in RCX, RDX, R8, R9 with required 32-byte shadow space), and interpret basic tool output from `dumpbin` to confirm your program matches your intent. These are not language features to memorize — they are the observable mechanics of how a Windows process starts, runs, and stops.

## Toolchain: from source text to runnable PE executable

This course targets **Windows 11** with **Visual Studio 2022 or later**. You must work from the **x64 Native Tools Command Prompt for VS** (find it in your Start menu under "Visual Studio 2022" → "x64 Native Tools Command Prompt"). This specialized command prompt sets environment variables so `ml64.exe` (Microsoft Macro Assembler for x64) and `link.exe` (Microsoft linker) are in your PATH. Verify with `ml64 /?` and `link /?`.

The basic build cycle has two steps. First, `ml64 /c program.asm` assembles your source text (`program.asm`) into an object file (`program.obj`) containing machine code and metadata. The `/c` flag means "compile only, do not link." Second, `link /OUT:program.exe /ENTRY:main /SUBSYSTEM:CONSOLE program.obj kernel32.lib` links the object file with the Win32 import library (`kernel32.lib`) into an executable binary named `program.exe`. The `/ENTRY:main` flag specifies the entry point symbol, and `/SUBSYSTEM:CONSOLE` indicates a console (not GUI) application. The linker resolves symbols, lays out PE (Portable Executable) sections, and produces a file the Windows loader can run. Run the program with `.\program.exe` (or just `program`) and check its exit status with `echo %ERRORLEVEL%` in cmd.exe or `$LASTEXITCODE` in PowerShell.

Repeat this cycle until it becomes automatic: edit `.asm`, assemble with `ml64 /c`, link with `link`, run, inspect. This is your feedback loop.

## How your program talks to Windows: the Win32 API

Your program is a sequence of instructions and data loaded into memory. The CPU fetches each instruction from memory, decodes it, executes it, and moves to the next. Instructions can read and write registers (small, fast storage inside the CPU) and memory (larger, slower, addressed storage). But the CPU alone cannot read files, print to the terminal, or allocate more memory — those operations require cooperation from the Windows kernel.

Unlike Linux, where programs request kernel services using the `syscall` instruction with a number in `rax`, Windows programs call imported functions from system DLLs (dynamic-link libraries). The three most important for console programs are `GetStdHandle`, `WriteFile` (or `WriteConsoleA` for simpler console-only text), and `ExitProcess`, all exported from `kernel32.dll`. You import these by declaring them as `EXTERN` symbols and linking with `kernel32.lib`, which provides the import stubs. At runtime, the Windows loader resolves these stubs to the actual function addresses in `kernel32.dll`.

Windows uses the **Microsoft x64 calling convention**: the first four integer or pointer arguments go into **RCX, RDX, R8, R9** (in that order), and any additional arguments go on the stack above a required 32-byte **shadow space** (also called home space) that the caller must allocate. The shadow space is reserved for the callee to spill the register arguments if needed, though modern code rarely does this. Before every `call` instruction, you must ensure that RSP points to at least 32 bytes of free stack space, and that RSP is 16-byte aligned (the `call` itself pushes an 8-byte return address, misaligning it by 8, so your shadow space allocation should restore alignment). The return value comes back in RAX, just like on Linux.

For `WriteConsoleA(handle, buffer, chars_to_write, &chars_written, NULL)`, you set RCX to the console handle (obtained from `GetStdHandle`), RDX to the buffer address, R8 to the character count, R9 to the address of a variable that will receive the actual count written, and the fifth argument (NULL) goes at `[rsp+32]` (the first stack slot after shadow space). For `ExitProcess(exitCode)`, you set RCX to the exit code (a 32-bit unsigned integer, though you pass it as a 64-bit value in RCX). These are function calls, not syscalls, so you use the `call` instruction and the function returns normally.

## General-purpose registers and their size variants

x86-64 provides sixteen general-purpose registers (GPRs). Each has multiple names depending on how many bits you want to access:

| 64-bit | 32-bit | 16-bit | 8-bit low | Notes |
|--------|--------|--------|-----------|-------|
| `rax` | `eax` | `ax` | `al` | Accumulator; function return value |
| `rbx` | `ebx` | `bx` | `bl` | General use; nonvolatile (callee-saved) |
| `rcx` | `ecx` | `cx` | `cl` | First integer/pointer argument; volatile (caller-saved) |
| `rdx` | `edx` | `dx` | `dl` | Second integer/pointer argument; volatile |
| `rsi` | `esi` | `si` | `sil` | Source index; **nonvolatile on Windows** (callee-saved) |
| `rdi` | `edi` | `di` | `dil` | Destination index; **nonvolatile on Windows** (callee-saved) |
| `rbp` | `ebp` | `bp` | `bpl` | Base pointer (stack frame, optional); nonvolatile |
| `rsp` | `esp` | `sp` | `spl` | Stack pointer (top of stack) |
| `r8`–`r11` | `r8d`–`r11d` | `r8w`–`r11w` | `r8b`–`r11b` | R8, R9 are arguments 3 and 4; R8-R11 are volatile |
| `r12`–`r15` | `r12d`–`r15d` | `r12w`–`r15w` | `r12b`–`r15b` | General use; nonvolatile (callee-saved) |

The size you choose matters. Writing to a 32-bit register name (`eax`) **zero-extends** the value into the full 64-bit register (`rax`), meaning the upper 32 bits are cleared. Writing to an 8-bit register name (`al`) leaves the upper 56 bits of `rax` **unchanged**. This is an architectural rule you must internalize: `mov eax, 42` sets `rax` to exactly 42 (clearing the high bits), but `mov al, 42` only modifies the lowest byte.

**Critical for Windows:** RSI and RDI are **nonvolatile** registers under the Microsoft x64 ABI, meaning if you modify them in your function, you must save them on entry and restore them before returning. This is the opposite of the Linux System V ABI, where RSI and RDI are volatile (caller-saved) because they are used for the first two function arguments. On Windows, the first two arguments use RCX and RDX instead.

## Moving data with `mov` and the zero idiom

The `mov` instruction copies data from source to destination. In Intel/NASM syntax the destination comes first and the source second (`mov dest, src`): `mov rax, 42` puts the immediate value 42 into `rax`, and `mov rdi, rax` copies the contents of `rax` into `rdi`. You cannot `mov` directly from memory to memory; at most one operand can be a memory reference.

To zero a register, you could write `mov rax, 0`, which works but requires encoding the immediate value 0 in the instruction. The idiomatic way is `xor rax, rax` — exclusive-OR of a value with itself always produces zero, and this encoding is shorter and recognized by the CPU's dependency-tracking logic. You will see `xor edi, edi` (zeroing the 32-bit `edi`, which zero-extends to `rdi`) frequently in examples.

## PE/COFF sections and data declarations in MASM

An assembly source file is divided into **sections**. In MASM, you use directives to declare sections: `.code` for executable code, `.data` for initialized read-write data, `.const` for read-only constants, and `.data?` for uninitialized zero-filled data (which occupies no file space — the loader zeros it at load time). These MASM directives map to PE (Portable Executable) sections: `.code` becomes the `.text` section in the PE file, `.data` becomes `.data`, `.const` becomes `.rdata` (read-only data), and `.data?` becomes uninitialized space in `.data`.

You declare data with directives like `BYTE` (1 byte), `WORD` (2 bytes), `DWORD` (4 bytes), and `QWORD` (8 bytes). MASM also accepts the lowercase synonyms `db`, `dw`, `dd`, `dq` from other assemblers. For example, `msg BYTE "Hello", 10, 0` declares a byte sequence containing the ASCII codes for "Hello", followed by byte 10 (newline) and a null terminator. The special symbol `$` represents the current assembly address, so `msg_len EQU $ - msg` defines `msg_len` as the distance in bytes from label `msg` to the current position — in other words, the length of `msg`. MASM uses `EQU` (uppercase or lowercase) for constants, which cannot be reassigned; you can also use `=` for reassignable symbols, but `EQU` is more common for true constants.

## Entry point: `main PROC` and the linker

When you link with `link.exe`, you specify the entry point with the `/ENTRY:` flag (e.g., `/ENTRY:main`). In MASM, you define procedures with the `PROC` and `ENDP` directives. A procedure declared with `PROC` is implicitly public when named as the entry point, so you do not need a separate `PUBLIC` declaration (though you can include one for clarity). You must end the file with the `END` directive, optionally naming the entry point again:

<!-- LISTING-PENDING: lessons/00-tools-registers-mov-syscall/listings/entry-skeleton.asm -->

```asm
.code
main PROC
    ; your code here
    ret
main ENDP
END
```

This is a **linker and MASM convention**, not a language keyword. The `PROC`/`ENDP` pair defines a procedure; `END` marks the end of the source file. If you forget `END`, the assembler will issue an error. The linker expects the symbol you named with `/ENTRY:` to exist and be a valid code address; if you misspell it or forget to define `main`, the linker will complain about an unresolved entry point.

## Worked example: printing "Hello" and exiting

Let's walk through a complete program that prints "Hello, asm\n" to stdout and exits with status 0. Here is the source:

<!-- LISTING-PENDING: lessons/00-tools-registers-mov-syscall/listings/hello-world.asm -->

```asm
EXTERN GetStdHandle:PROC
EXTERN WriteConsoleA:PROC
EXTERN ExitProcess:PROC

.data
    msg BYTE "Hello, asm", 10, 0
    msg_len EQU $ - msg - 1    ; subtract 1 for null terminator

.data?
    charsWritten QWORD ?

.code
main PROC
    ; Allocate shadow space (32 bytes minimum, but we need 40 for alignment)
    ; After 'call' pushes 8 bytes, stack is misaligned by 8, so add 40 to realign
    sub rsp, 40

    ; Get stdout handle: GetStdHandle(STD_OUTPUT_HANDLE = -11)
    mov rcx, -11            ; STD_OUTPUT_HANDLE constant
    call GetStdHandle
    mov rbx, rax            ; save handle in RBX (nonvolatile)

    ; Write to console: WriteConsoleA(handle, buffer, chars, &written, NULL)
    mov rcx, rbx            ; console handle
    lea rdx, msg            ; buffer address
    mov r8d, msg_len        ; number of characters (32-bit is fine, zero-extends)
    lea r9, charsWritten    ; address of DWORD to receive count
    mov QWORD PTR [rsp+32], 0  ; fifth argument (NULL) at first stack slot after shadow space
    call WriteConsoleA

    ; Exit: ExitProcess(0)
    xor ecx, ecx            ; exit code 0 (writing ECX zero-extends RCX)
    call ExitProcess
    ; ExitProcess does not return
main ENDP
END
```

Step through the reasoning. In `.data`, we declare `msg` as a byte sequence: the ASCII codes for "Hello, asm", byte 10 (newline), and a null terminator (0). The null terminator is not required by `WriteConsoleA`, which takes an explicit character count, but it is good practice when you might later pass the string to a function expecting a C-style string. `msg_len EQU $ - msg - 1` computes the length in bytes by subtracting the address of `msg` from the current address `$`, then subtracting 1 to exclude the null terminator. After assembling the 13-byte sequence, `$` points one byte past the null, so `$ - msg` equals 13, and `msg_len` equals 12. In `.data?`, we reserve 8 bytes (a QWORD) for `charsWritten`, which `WriteConsoleA` will fill with the actual number of characters written. This variable is uninitialized, so it goes in `.data?` to save file space.

In `.code`, we define `main PROC` as the entry point. The first instruction allocates **40 bytes** on the stack. Why 40? We need 32 bytes of shadow space (the Microsoft x64 ABI requires this before every call), plus the stack must remain 16-byte aligned. The `call` instruction will push an 8-byte return address, misaligning RSP by 8. So we allocate 40 bytes: 32 for shadow space and 8 for alignment padding. After `sub rsp, 40`, RSP is 16-byte aligned again, minus the 8 bytes the next `call` will push, leaving RSP correctly aligned inside the called function.

Next, we call `GetStdHandle(STD_OUTPUT_HANDLE)` to obtain a handle to the standard output. The constant `STD_OUTPUT_HANDLE` is -11 (a pseudo-handle). We place -11 in RCX (the first argument register) and `call GetStdHandle`. The handle returns in RAX. We save it in RBX because RBX is nonvolatile (callee-saved) — any function we call must preserve RBX, so we can trust it will still hold our handle after `WriteConsoleA` returns.

Next, we call `WriteConsoleA(handle, buffer, chars_to_write, &chars_written, NULL)`. The five arguments are:
- RCX: console handle (we move RBX, the saved handle, into RCX)
- RDX: buffer address (we use `lea rdx, msg` to load the address; in MASM 64-bit mode, this generates RIP-relative addressing automatically)
- R8: character count (we move `msg_len`, which is 12, into R8D; writing a 32-bit register zero-extends the upper 32 bits of the 64-bit register)
- R9: address of a QWORD to receive the count written (we use `lea r9, charsWritten`)
- Fifth argument at `[rsp+32]`: NULL (we mov 0 into the first stack slot after shadow space, which is at offset 32 from RSP)

Then `call WriteConsoleA` invokes the function. It writes 12 characters (excluding the null terminator) to the console, fills `charsWritten` with 12, and returns a nonzero value in RAX (indicating success; zero would mean failure, in which case you would call `GetLastError` to learn why).

Finally, we prepare to exit: `xor ecx, ecx` zeroes RCX (the exit code) idiomatically, and `call ExitProcess` terminates the process. `ExitProcess` does not return; the process ends immediately.

### A plausible wrong reading (and why it fails)

A common mistake is to forget the shadow space allocation or to misalign the stack before calling a function. Suppose you remove the `sub rsp, 40` instruction, thinking "I'm only using register arguments, so I don't need stack space." When you `call GetStdHandle`, the function expects the caller to have reserved 32 bytes of shadow space at `[rsp]` through `[rsp+31]`. Without it, the function might write into your return address (at `[rsp]`) or other important stack data, corrupting the stack and causing a crash or silent misbehavior when the function returns.

Another common mistake is to use the Linux (System V) calling convention registers by habit: putting the first argument in RDI instead of RCX. If you write `mov rdi, -11` and `call GetStdHandle`, the function looks for its first argument in RCX, finds whatever garbage value happens to be there, interprets it as a pseudo-handle constant, and returns an invalid handle or crashes. Nothing about x86-64 function calls is automatic or forgiving — the ABI is a contract, and both sides must follow it exactly. Consult the Microsoft x64 calling convention documentation and map parameters by **role** (first arg → RCX, second → RDX, third → R8, fourth → R9, fifth and beyond → stack), not by Linux habit.

## Distinctions worth keeping straight

| Confusion | What actually separates them |
|-----------|------------------------------|
| `mov rax, 42` vs `mov eax, 42` | Both leave all of `rax` equal to 42. Writing any 32-bit register zeroes the upper 32 bits of the full 64-bit register (zero-extension), so `mov eax, 42` clears the top half of `rax` too. Because 42 fits in 32 bits, MASM will assemble `mov rax, 42` as effectively `mov eax, 42` (5 bytes) unless the immediate requires the full 64-bit width. |
| `mov al, 42` vs `mov eax, 42` | `mov al, 42` only changes the lowest byte of `rax`; the upper bits remain unchanged. `mov eax, 42` zero-extends and clears all upper bits. |
| `xor ecx, ecx` vs `mov rcx, 0` | Both set RCX to zero, but `xor ecx, ecx` (or `xor rcx, rcx`) produces a shorter encoding and is the idiomatic form. Writing ECX zero-extends into RCX automatically. |
| Win32 API calls vs `syscall` | Windows programs call imported functions (like `GetStdHandle`, `WriteConsoleA`, `ExitProcess`) using the `call` instruction and the Microsoft x64 calling convention. The `syscall` instruction exists on x86-64 but is not used by Windows user-mode programs — syscall numbers are undocumented and change between Windows builds. Linux uses `syscall` with stable syscall numbers; Windows uses a stable API of exported functions. |
| `main PROC` vs `_start` | On Windows with `link.exe /ENTRY:main`, your entry point is `main` (or whatever symbol you specify with `/ENTRY`). There is no C runtime unless you link with the C runtime library (`msvcrt.lib` or similar), which we do not do in early lessons. On Linux with `ld`, the default entry point is `_start`. The entry point name is a convention, not a language feature. |
| `ml64 /c` vs `ml64` alone | The `/c` flag means "assemble only, do not link." Without it, `ml64` will attempt to invoke the linker, which may fail with missing flags. Always use `/c` for assembly-only, then run `link.exe` explicitly with the required flags. |
| Shadow space (32 bytes) vs no allocation | The Microsoft x64 ABI **requires** the caller to allocate at least 32 bytes (4 × 8-byte slots) on the stack before every `call`, even if the function has fewer than four arguments. This shadow space is reserved for the callee to spill RCX, RDX, R8, R9 if needed. Omitting it violates the ABI and can corrupt the stack. On Linux, there is a 128-byte "red zone" below RSP that leaf functions can use without adjusting RSP, but no shadow space requirement for calls. |
| RSI/RDI nonvolatile vs volatile | On Windows, RSI and RDI are **nonvolatile** (callee-saved): if your function modifies them, you must save them on entry and restore them before returning. On Linux (System V ABI), RSI and RDI are **volatile** (caller-saved) because they hold the first two function arguments and the callee is free to clobber them. This is a fundamental ABI difference. |

## Check yourself

1. What happens to the upper 32 bits of RAX when you execute `mov eax, 100`? What about when you execute `mov al, 100`?
2. Trace the register values after each instruction in the "Hello" example above. What is in RCX, RDX, R8, and R9 just before the `call WriteConsoleA`? What is in RAX after `WriteConsoleA` returns (assuming success)?
3. Why must you allocate shadow space before every `call` instruction, even if the function you are calling has fewer than four arguments or no arguments at all? What might happen if you forget it?
4. Explain why RSI and RDI are nonvolatile (callee-saved) on Windows but volatile (caller-saved) on Linux. What does this difference mean for your code if you modify RSI or RDI in a Windows function?
5. Rewrite the exit sequence to exit with status 42 instead of 0. Which register changes, and what value does it hold? (Remember that `ExitProcess` takes an unsigned 32-bit exit code in the low 32 bits of RCX.)

## Key takeaways

- Assembly source is text that `ml64.exe` translates to machine code in an object file (`.obj`); `link.exe` then links that object with import libraries into a PE executable the Windows loader can run.
- On x86-64, every general-purpose register has 64-, 32-, 16-, and 8-bit views; writing to the 32-bit name zero-extends into the full 64 bits, but writing to the 8- or 16-bit view leaves upper bits unchanged.
- Windows programs call Win32 API functions (like `GetStdHandle`, `WriteConsoleA`, `ExitProcess`) using the `call` instruction and the Microsoft x64 calling convention: first four arguments in RCX, RDX, R8, R9, return value in RAX.
- The Microsoft x64 ABI requires the caller to allocate 32 bytes of shadow space on the stack before every `call`, and to maintain 16-byte stack alignment at the point of the `call` instruction. Omitting shadow space violates the ABI and can corrupt the stack.
- RSI and RDI are **nonvolatile** (callee-saved) registers on Windows, meaning you must preserve them if you modify them. This is the opposite of Linux, where they are volatile (caller-saved) argument registers.
- `xor reg, reg` is the idiomatic way to zero a register because it produces shorter code and is recognized by CPU optimizations; `xor ecx, ecx` zero-extends into RCX automatically.
- The linker expects the symbol you specify with `/ENTRY:` (e.g., `/ENTRY:main`) to exist and be a valid code address; MASM procedures are defined with `PROC`/`ENDP` and the file must end with the `END` directive.

## Lookup (reference only, not curriculum)

- **Microsoft x64 calling convention:** https://learn.microsoft.com/en-us/cpp/build/x64-software-conventions
- **MASM for x64 (ml64.exe):** https://learn.microsoft.com/en-us/cpp/assembler/masm/masm-for-x64-ml64-exe
- **Win32 API functions (kernel32):** https://learn.microsoft.com/en-us/windows/win32/api/
  - `GetStdHandle`: https://learn.microsoft.com/en-us/windows/console/getstdhandle
  - `WriteConsoleA`: https://learn.microsoft.com/en-us/windows/console/writeconsole
  - `ExitProcess`: https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-exitprocess
- **x86-64 instruction reference:** Intel® 64 and IA-32 Architectures Software Developer's Manual, Volume 2 (Instruction Set Reference) — same as Linux; x86-64 instructions are platform-independent
- **PE/COFF format:** https://learn.microsoft.com/en-us/windows/win32/debug/pe-format
- **Tool inspection:** `dumpbin /disasm <file>` (disassemble), `dumpbin /headers <file>` (view PE headers)
- **Debugger:** Visual Studio debugger, WinDbg, or `x64dbg` for low-level assembly debugging

## Exercises

Work in `exercises/`. Build commands are in each file header. Solutions mirror names under `solutions/`.
