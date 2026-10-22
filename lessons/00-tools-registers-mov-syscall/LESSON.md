# Lesson 00 — Tools, Registers, `mov`, Win32 API Calls

Assembly is not an opaque ritual. This lesson makes the toolchain cycle concrete: you type instructions in a text file, `ml64.exe` translates them to machine code, `link.exe` packages the result as a Windows PE executable, and your CPU runs it. Once you understand how data moves between registers and how to request operating system services via the Win32 API, you can write programs that do real work. By the end of this lesson, you will build executables from scratch, name every general-purpose register, call Win32 API functions to print text and exit cleanly, and understand why Windows uses imported function calls where Linux uses the `syscall` instruction.

## What this lesson asks of you

You must be able to assemble and link a freestanding x86-64 PE executable using `ml64.exe` and `link.exe /ENTRY:main /SUBSYSTEM:CONSOLE`, write a program that calls Win32 API functions (`GetStdHandle`, `WriteFile`, and `ExitProcess`) to print text and terminate, and name the general-purpose registers and their size variants (64/32/16/8-bit). You will also distinguish between `mov` (data transfer) and `xor reg, reg` (the idiomatic zero), understand the Microsoft x64 calling convention (first four arguments in RCX, RDX, R8, R9 with required 32-byte shadow space), and interpret basic tool output from `dumpbin` to confirm your program matches your intent. These are not language features to memorize — they are the observable mechanics of how a Windows process starts, runs, and stops.

## Toolchain: from source text to runnable PE executable

This course targets **Windows 11** with **Visual Studio 2022 or later**. You must work from the **x64 Native Tools Command Prompt for VS** (Start menu → Visual Studio 2022 → x64 Native Tools Command Prompt). That prompt puts `ml64.exe` (Microsoft Macro Assembler for x64) and `link.exe` (Microsoft linker) on PATH. Verify with `ml64 /?` and `link /?`.

The basic build cycle has two steps. First, `ml64 /c program.asm` assembles source into `program.obj`. The `/c` flag means assemble only, do not link. Second, `link /OUT:program.exe /ENTRY:main /SUBSYSTEM:CONSOLE program.obj kernel32.lib` links the object with the Win32 import library into a console PE executable. `/ENTRY:main` names the entry symbol. `/SUBSYSTEM:CONSOLE` tells the loader this is a console process, not a GUI process. Run with `program.exe` and inspect the exit status with `echo %ERRORLEVEL%` in cmd.exe or `$LASTEXITCODE` in PowerShell.

The listing files in this lesson show the exact `ml64` and `link` command lines in their headers. Repeat the cycle until it is automatic: edit `.asm`, assemble, link, run, inspect.

## How your program talks to Windows: the Win32 API

Your program is a sequence of instructions and data loaded into memory. The CPU fetches each instruction, decodes it, executes it, and moves to the next. Instructions can read and write registers and memory. The CPU alone cannot print to the console or exit a process — those operations require the Windows kernel.

Linux user-mode programs request kernel services with the `syscall` instruction and a number in `rax`. That approach does not carry over. Windows syscall numbers are undocumented and change between builds; user-mode code goes through exported DLL functions instead. The three functions this lesson uses are `GetStdHandle`, `WriteFile`, and `ExitProcess`, all from `kernel32.dll`. You import them by declaring `EXTRN Name:PROC` (MASM also accepts `EXTERN`) and linking `kernel32.lib`. At runtime the loader patches the Import Address Table so `call WriteFile` becomes an indirect call through the IAT.

Windows uses the **Microsoft x64 calling convention**: the first four integer or pointer arguments go in **RCX, RDX, R8, R9**. Further arguments go on the stack starting at `[rsp+32]`. The caller must allocate **32 bytes of shadow space** (home space) before every `call`. Return values come back in RAX.

`GetStdHandle` takes one argument: the standard-handle constant in RCX. `STD_OUTPUT_HANDLE` is −11; `STD_ERROR_HANDLE` is −12; `STD_INPUT_HANDLE` is −10. The HANDLE comes back in RAX.

`WriteFile` takes five arguments: HANDLE in RCX, buffer pointer in RDX, byte count in R8, pointer to a DWORD that receives the written count in R9, and an OVERLAPPED pointer (NULL for synchronous I/O) at `[rsp+32]`.

`ExitProcess` takes the exit code in RCX (UINT, 32-bit). It does not return.

## General-purpose registers and their size variants

x86-64 provides sixteen general-purpose registers. Each has multiple names depending on how many bits you access:

| 64-bit | 32-bit | 16-bit | 8-bit low | Notes |
|--------|--------|--------|-----------|-------|
| `rax` | `eax` | `ax` | `al` | Accumulator; function return value |
| `rbx` | `ebx` | `bx` | `bl` | General use; nonvolatile (callee-saved) |
| `rcx` | `ecx` | `cx` | `cl` | First integer/pointer argument; volatile |
| `rdx` | `edx` | `dx` | `dl` | Second integer/pointer argument; volatile |
| `rsi` | `esi` | `si` | `sil` | Source index; **nonvolatile on Windows** |
| `rdi` | `edi` | `di` | `dil` | Destination index; **nonvolatile on Windows** |
| `rbp` | `ebp` | `bp` | `bpl` | Frame pointer (optional); nonvolatile |
| `rsp` | `esp` | `sp` | `spl` | Stack pointer |
| `r8`–`r11` | `r8d`–`r11d` | `r8w`–`r11w` | `r8b`–`r11b` | R8, R9 are arguments 3 and 4; R8–R11 volatile |
| `r12`–`r15` | `r12d`–`r15d` | `r12w`–`r15w` | `r12b`–`r15b` | General use; nonvolatile |

Writing a 32-bit register name (`eax`) **zero-extends** into the full 64-bit register. Writing an 8-bit name (`al`) leaves the upper 56 bits unchanged. Listing `03-register-sizes` makes that observable.

**Critical for Windows:** RSI and RDI are **nonvolatile**. If a procedure that returns modifies them, it must save and restore them. This is the opposite of the Linux System V ABI, where they are volatile argument registers. RBX, RBP, and R12–R15 are also nonvolatile. RAX, RCX, RDX, R8–R11 are volatile.

## Moving data with `mov` and the zero idiom

`mov dest, src` copies from source to destination. You cannot `mov` memory to memory; at most one operand may be a memory reference. Listing `05-mov-data-movement` moves immediates into registers, copies register to register, and uses `add` to accumulate an exit code.

To zero a register, `mov ecx, 0` works. The idiomatic form is `xor ecx, ecx`: XOR of a value with itself is zero, the encoding is shorter, and writing ECX zero-extends into RCX. Listing `04-xor-zero-idiom` shows both.

## PE/COFF sections and data declarations in MASM

MASM section directives map onto PE sections:

| MASM | PE section | Purpose |
|------|------------|---------|
| `.CODE` | `.text` | Executable instructions |
| `.DATA` | `.data` | Initialized read-write data |
| `.CONST` | `.rdata` | Read-only initialized data |
| `.DATA?` | `.bss`/uninitialized `.data` | Uninitialized storage, zeroed at load |

MASM is case-insensitive for directives. The listings use `.CODE`, `.DATA`, `.DATA?`. Data may be declared with `DB`/`DW`/`DD`/`DQ` or `BYTE`/`WORD`/`DWORD`/`QWORD`. `$` is the current assembly address, so `msg_len EQU $ - msg` is the length of `msg` in bytes.

Windows console text conventionally uses CRLF (`13, 10`), not Unix LF (`10`). The hello listing stores `"Hello, asm", 13, 10`.

## Entry point: `main PROC`, unwind info, and the linker

`link.exe /ENTRY:main` looks for the symbol `main`. `PROC`/`ENDP` define a procedure. The file must end with `END`.

A procedure that saves nonvolatile registers or allocates stack and then calls other functions should emit **unwind information** so Windows can walk the stack on exceptions. ml64 does that with `PROC FRAME` plus prologue directives:

- `.pushreg reg` — records a `push` of a nonvolatile register
- `.allocstack n` — records `sub rsp, n`
- `.endprolog` — marks the end of the prologue; the body follows

Those directives assemble to no instructions. They describe the prologue to the unwinder. Listing `02-hello-world` uses this form.

The smallest complete program that only calls `ExitProcess` does not need FRAME. It still needs 32 bytes of shadow space before the call:

```asm
; Listing 01: Exit with status code
;
; Purpose: Demonstrates the minimal Win32 program that exits with a specific status.
; Expected exit: 42
; Expected stdout: (none)
;
; Build: ml64 /c /Fo01-exit-code.obj 01-exit-code.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-exit-code.exe 01-exit-code.obj kernel32.lib
; Run: 01-exit-code.exe & echo %ERRORLEVEL%

.CODE

EXTRN ExitProcess:PROC

main PROC
    mov ecx, 42                ; Exit status in RCX (first argument, MS x64 ABI)
    sub rsp, 40                ; Shadow space (32 bytes required by ABI)
    call ExitProcess           ; Never returns
main ENDP

END
```

`mov ecx, 42` zero-extends into RCX. `sub rsp, 32` is the mandatory shadow space. `ExitProcess` never returns, so there is no `add rsp, 32` and no `ret`.

## Worked example: printing "Hello" and exiting

The complete stdout program is listing `02-hello-world`. It uses `WriteFile` (the same API used for files and redirected stdout) rather than `WriteConsoleA` (console-only).

```asm
; Listing 02: Hello, World
;
; Purpose: Complete program that writes "Hello, asm\n" to stdout and exits cleanly.
; Expected exit: 0
; Expected stdout: "Hello, asm\n"
;
; Build: ml64 /c /Fo02-hello-world.obj 02-hello-world.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-hello-world.exe 02-hello-world.obj kernel32.lib

.DATA
msg DB "Hello, asm", 13, 10   ; Message with CR LF (Windows line ending)
msg_len EQU $ - msg            ; Length = 12 bytes

.DATA?
bytes_written DQ ?             ; Storage for WriteFile output parameter

.CODE

EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push rbx                   ; Save nonvolatile register
    .pushreg rbx
    sub rsp, 48                ; Shadow space + 5th arg slot + alignment
    .allocstack 48
    .endprolog

    ; GetStdHandle(STD_OUTPUT_HANDLE = -11)
    mov ecx, -11               ; STD_OUTPUT_HANDLE
    call GetStdHandle          ; Returns handle in RAX

    mov rbx, rax               ; Save stdout handle in nonvolatile RBX

    ; WriteFile(handle, buffer, count, &bytes_written, NULL)
    mov rcx, rbx               ; arg1: handle
    lea rdx, msg               ; arg2: buffer address
    mov r8d, msg_len           ; arg3: byte count
    lea r9, bytes_written      ; arg4: pointer to bytes written
    mov qword ptr [rsp+32], 0  ; arg5 (on stack): overlapped = NULL
    call WriteFile

    xor ecx, ecx               ; Exit status 0
    call ExitProcess
main ENDP

END
```

Step through the register and stack state.

`.DATA` holds `msg`: ASCII `"Hello, asm"` plus CR (13) and LF (10), 12 bytes. `msg_len EQU $ - msg` is 12. `.DATA?` reserves `bytes_written`. `WriteFile` writes a DWORD (4 bytes) through that pointer; the listing reserves 8. Extra space is harmless if nothing else shares those bytes.

`main PROC FRAME` begins the unwind-aware prologue. After the process starts, RSP holds the return address and is 8 mod 16. `push rbx` stores the incoming RBX and leaves RSP 0 mod 16. `sub rsp, 48` allocates 32 bytes of shadow space, the fifth `WriteFile` argument slot at `[rsp+32]`, and 8 more bytes so the saved RBX sits at `[rsp+48]` instead of colliding with that slot. `.pushreg` / `.allocstack` / `.endprolog` record that prologue for the unwinder. There is no `add rsp` / `pop rbx` before `ExitProcess`: the call never returns, so the frame stays live until the process dies.

`mov ecx, -11` then `call GetStdHandle` returns a HANDLE in RAX. The next `call` will clobber RAX, RCX, RDX, R8–R11, so the HANDLE is copied into RBX (nonvolatile).

`WriteFile` setup immediately before the call:

| Slot | Value |
|------|--------|
| RCX | stdout HANDLE (from RBX) |
| RDX | address of `msg` (`lea` is RIP-relative in 64-bit MASM) |
| R8 | 12 (`msg_len`, written as `r8d`) |
| R9 | address of `bytes_written` |
| `[rsp+32]` | 0 (lpOverlapped = NULL) |

Then `xor ecx, ecx` / `call ExitProcess` terminates with status 0.

### A plausible wrong reading (and why it fails)

*"I already pushed RBX, so 32 bytes of shadow space is enough; `[rsp+32]` is past the shadow and free for `lpOverlapped`."*

**Why it fails:** After `push rbx` then `sub rsp, 32`, the saved RBX lives at `[rsp+32]`. Storing 0 there overwrites the saved nonvolatile. Listing `02-hello-world` therefore allocates **48** bytes (`sub rsp, 48` / `.allocstack 48`). After that allocation, `[rsp+32]` is the fifth-argument slot inside the frame; the saved RBX is at `[rsp+48]`. Listing `07-stderr-output` does not push a nonvolatile: it uses a plain `main PROC`, `sub rsp, 56`, and keeps the HANDLE in RAX until the `WriteFile` setup. Listing `06-write-two-messages` pushes RBX and RSI (16 bytes) then `sub rsp, 40`, so `[rsp+32]` is again the fifth-arg slot and not a saved register. `ExitProcess` is called with the frame still live — no teardown — because it never returns.

A second wrong reading is putting the first argument in RDI because Linux does. `GetStdHandle` reads RCX. Garbage in RCX produces `INVALID_HANDLE_VALUE` or a crash. Map arguments by role: 1→RCX, 2→RDX, 3→R8, 4→R9, 5+→`[rsp+32]` onward.

## Register sizes, XOR-zero, and `mov`

Listing `03-register-sizes` fills RAX with −1, then writes 42 to EAX (RAX becomes `0x000000000000002A`) versus AL (RAX becomes `0xFFFFFFFFFFFFFF2A`). It exits 42.

```asm
; Listing 03: Register size variants and zero-extension
;
; Purpose: Demonstrates how writing to 32-bit register names zero-extends to 64 bits,
;          while writing to 8-bit or 16-bit names leaves upper bits unchanged.
; Expected exit: 42
; Expected stdout: (none)
;
; Build: ml64 /c /Fo03-register-sizes.obj 03-register-sizes.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-register-sizes.exe 03-register-sizes.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40                ; Shadow space

    ; Demonstrate zero-extension with 32-bit write
    mov rax, -1                ; Fill RAX with all 1s (0xFFFFFFFFFFFFFFFF)
    mov eax, 42                ; Write to EAX zeros upper 32 bits
                               ; RAX is now 0x000000000000002A (42)

    ; Demonstrate partial update with 8-bit write
    mov rax, -1                ; Fill RAX with all 1s again
    mov al, 42                 ; Write to AL leaves upper 56 bits unchanged
                               ; RAX is now 0xFFFFFFFFFFFFFF2A

    ; Exit with 42 (using zero-extending 32-bit write)
    mov ecx, 42                ; Zero-extends to RCX
    call ExitProcess
main ENDP

END
```

Listing `04-xor-zero-idiom` zeros ECX two ways and exits 0:

```asm
; Listing 04: The XOR-to-zero idiom
;
; Purpose: Demonstrates the idiomatic way to zero a register using XOR.
; Expected exit: 0
; Expected stdout: (none)
;
; Build: ml64 /c /Fo04-xor-zero-idiom.obj 04-xor-zero-idiom.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-xor-zero-idiom.exe 04-xor-zero-idiom.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40                ; Shadow space

    ; Two ways to zero a register:
    mov ecx, 0                 ; Explicit zero (works but longer encoding)
    
    ; Better: XOR idiom
    xor ecx, ecx               ; Shorter encoding, recognized by CPU
                               ; XOR of anything with itself = 0
                               ; Also zero-extends to 64 bits (ECX -> RCX)

    call ExitProcess           ; Exit with 0
main ENDP

END
```

Listing `05-mov-data-movement` accumulates 5 + 5 + 5 = 15 in RAX and exits 15. It uses RBX without saving it. `main` never returns (`ExitProcess`), so the process does not restore a caller. A returning procedure would have to `push rbx` / `pop rbx`.

```asm
; Listing 05: Moving data with MOV
;
; Purpose: Demonstrates various forms of the MOV instruction.
; Expected exit code: 15
; Expected output: (none)
;
; Build: ml64 /c /Fo05-mov-data-movement.obj 05-mov-data-movement.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:05-mov-data-movement.exe 05-mov-data-movement.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40                ; Shadow space

    ; Immediate to register
    mov rax, 5                 ; RAX = 5

    ; Register to register
    mov rbx, rax               ; RBX = RAX = 5

    ; Add to get 10
    add rax, rbx               ; RAX = 10

    ; Move to another register
    mov rdx, rax               ; RDX = 10
    
    ; Compute exit code: 10 + 5 = 15
    add rax, rbx               ; RAX = 15
    
    ; Move to exit parameter register
    mov rcx, rax               ; RCX = 15
    
    call ExitProcess
main ENDP

END
```

## Two writes, then stderr

`GetStdHandle` once, then two `WriteFile` calls. HANDLE stays in RBX across both calls because RBX is nonvolatile. RSI is also pushed (unwind-matched). Two 8-byte pushes plus `sub rsp, 40` keep `[rsp+32]` off the saved registers. `ExitProcess` is called with that frame still live.

```asm
; Listing 06: Multiple writes to stdout
;
; Purpose: Demonstrates calling WriteFile multiple times with different messages.
; Expected exit: 0
; Expected stdout: "First line\nSecond line\n"
;
; Build: ml64 /c /Fo06-write-two-messages.obj 06-write-two-messages.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:06-write-two-messages.exe 06-write-two-messages.obj kernel32.lib

.DATA
msg1 DB "First line", 13, 10
msg1_len EQU $ - msg1
msg2 DB "Second line", 13, 10
msg2_len EQU $ - msg2

.DATA?
bytes_written DQ ?

.CODE

EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push rbx
    .pushreg rbx
    push rsi
    .pushreg rsi
    sub rsp, 40                ; Shadow + 5th WriteFile arg (after 2 pushes)
    .allocstack 40
    .endprolog

    ; Get stdout handle
    mov ecx, -11
    call GetStdHandle
    mov rbx, rax               ; Save handle

    ; Write first message
    mov rcx, rbx
    lea rdx, msg1
    mov r8d, msg1_len
    lea r9, bytes_written
    mov qword ptr [rsp+32], 0
    call WriteFile

    ; Write second message
    mov rcx, rbx
    lea rdx, msg2
    mov r8d, msg2_len
    lea r9, bytes_written
    mov qword ptr [rsp+32], 0
    call WriteFile

    xor ecx, ecx
    call ExitProcess
main ENDP

END
```

Listing `07-stderr-output` writes `"Error message"` to stderr with **no** CR LF. `msg_len EQU $ - msg` is 13, not 15. The header is `Expected output: (to stderr) Error message`. `bytes_written` is a `DWORD`. `main` is a plain `PROC` (no `FRAME`): `sub rsp, 56` covers shadow space plus the fifth `WriteFile` slot with 16-byte alignment at the `call`. `GetStdHandle(-12)` leaves the HANDLE in RAX; the next `WriteFile` takes that HANDLE in RCX (no RBX save). Redirect with `2>` to see the text separately from stdout. Expected exit: **0**.

```asm
; Listing 07: Writing to stderr instead of stdout
;
; Purpose: Demonstrates using GetStdHandle with STD_ERROR_HANDLE.
; Expected exit: 0
; Expected output: (to stderr) Error message
;
; Build: ml64 /c /Fo07-stderr-output.obj 07-stderr-output.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:07-stderr-output.exe 07-stderr-output.obj kernel32.lib
; Run: 07-stderr-output.exe 2>&1

.DATA
msg DB "Error message"
msg_len EQU $ - msg

.DATA?
bytes_written DWORD ?

.CODE

EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC

main PROC
    sub     rsp, 56

    mov     rcx, -12
    call    GetStdHandle

    mov     rcx, rax
    lea     rdx, msg
    mov     r8d, msg_len
    lea     r9, bytes_written
    mov     QWORD PTR [rsp+32], 0
    call    WriteFile

    xor     ecx, ecx
    call    ExitProcess
main ENDP

END
```

## Distinctions worth keeping straight

| Confusion | What actually separates them |
|-----------|------------------------------|
| `mov rax, 42` vs `mov eax, 42` | Writing any 32-bit register zeroes the upper 32 bits. Because 42 fits in 32 bits, both leave RAX equal to 42. |
| `mov al, 42` vs `mov eax, 42` | `al` changes only the low byte. `eax` zero-extends. |
| `xor ecx, ecx` vs `mov rcx, 0` | Both zero RCX; XOR is the idiomatic shorter form. |
| Win32 `call` vs Linux `syscall` | Windows user-mode code calls exported functions. Syscall numbers are undocumented and change between builds. |
| `WriteFile` vs `WriteConsoleA` | `WriteFile` works for files, pipes, and redirected stdout. `WriteConsoleA` talks to a console and fails if stdout is redirected. This course's listings use `WriteFile`. |
| `main PROC` vs `_start` | `link /ENTRY:main` names the entry. Linux `ld` defaults to `_start`. |
| Shadow space vs 5th argument | `[rsp+0..31]` is shadow space. The 5th argument is `[rsp+32]`, which requires extra allocation if you also `push`ed registers. |
| RSI/RDI volatility | Nonvolatile on Windows; volatile argument registers on Linux. |
| `PROC` vs `PROC FRAME` | FRAME plus `.pushreg` / `.allocstack` / `.endprolog` emits unwind codes. Needed when you save nonvolatiles or allocate a frame and may be unwound. |

## Check yourself

1. After `mov rax, -1` then `mov eax, 100`, what is in RAX? After `mov rax, -1` then `mov al, 100`?
2. Immediately before `call WriteFile` in listing `02-hello-world`, what is in RCX, RDX, R8, R9, and `[rsp+32]`?
3. Why allocate 32 bytes of shadow space before `call ExitProcess` even though it takes one argument?
4. Why are RSI and RDI nonvolatile on Windows? What must a returning procedure do if it uses them?
5. Change listing `01-exit-code` to exit 7. Which register holds 7 at the `call`?

## Key takeaways

- `ml64 /c` produces a COFF `.obj`; `link /ENTRY:main /SUBSYSTEM:CONSOLE ... kernel32.lib` produces a PE `.exe`.
- 32-bit writes zero-extend; 8- and 16-bit writes leave upper bits.
- Win32 calls use RCX, RDX, R8, R9, then `[rsp+32]`; return in RAX; 32-byte shadow space is mandatory.
- `PROC FRAME` with `.pushreg` / `.allocstack` / `.endprolog` is how ml64 emits unwind info.
- RSI and RDI are nonvolatile on Windows.
- `xor reg, reg` is the zero idiom.
- Linux `syscall` is not a portable Windows interface.

## Lookup (reference only, not curriculum)

- Microsoft x64 calling convention: https://learn.microsoft.com/en-us/cpp/build/x64-software-conventions
- MASM for x64 (ml64.exe): https://learn.microsoft.com/en-us/cpp/assembler/masm/masm-for-x64-ml64-exe
- `GetStdHandle`: https://learn.microsoft.com/en-us/windows/console/getstdhandle
- `WriteFile`: https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-writefile
- `ExitProcess`: https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-exitprocess
- x64 exception handling (unwind): https://learn.microsoft.com/en-us/cpp/build/exception-handling-x64
- PE/COFF format: https://learn.microsoft.com/en-us/windows/win32/debug/pe-format
- `dumpbin /disasm`, `dumpbin /headers`

## Exercises

Work in `exercises/`. Build commands are in each file header. Solutions mirror names under `solutions/`. The standalone listings quoted above are `lessons/00-tools-registers-mov-syscall/listings/01-exit-code.asm` through `07-stderr-output.asm` on Jack's PR #5.
