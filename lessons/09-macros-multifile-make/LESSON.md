# Lesson 09 — Macros, Multi-file, NMake

Every Win32 call you have written so far spelled `mov rcx, …` and `call ExitProcess` by hand. This lesson collapses that repetition into `EQU` constants and `MACRO` text, splits a program across object files that share `PUBLIC` / `EXTRN` symbols, and rebuilds only what changed with NMake or a PowerShell script. The assembler still emits the same instructions. You stop typing them twice.

Listings in this lesson declare imports with `EXTRN Name:PROC`. MASM also accepts `EXTERN`. Assemble and link from an x64 Native Tools prompt:

```bat
ml64 /c FILE.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE FILE.obj kernel32.lib && FILE.exe
echo %ERRORLEVEL%
```

Multi-file programs assemble each `.asm` separately, then pass every `.obj` to `link`. Helper objects in this lesson have no `main` and are not executables on their own.

## What this lesson asks of you

You replace repeated immediates with `EQU` and repeated instruction sequences with `MACRO`. You generate straight-line copies with `REPT` / `REPEAT` at assembly time, not with a runtime loop. You mark labels inside a macro `LOCAL` so a second expansion does not redefine the first. You export a procedure or a data label with `PUBLIC` in one file, import it with `EXTRN symbol:type` in another, and link the objects. You write NMake inference rules (or a PowerShell timestamp check) so a changed `.asm` rebuilds its `.obj` and the executable without reassembling everything else.

## Text substitution with EQU, TEXTEQU, and MACRO

MASM's macro processor runs before instruction encoding. It sees `EQU`, `TEXTEQU`, `MACRO`, `INCLUDE`, `REPT`, `IFDEF`, and their relatives, and it rewrites the source text. The CPU never executes a `MACRO` line. It executes whatever that line expanded into.

### Constants with EQU

`EQU` binds a symbol to a value computed at assembly time. You cannot redefine it later (unlike `=`, which allows reassignment). There is still no `01-*.asm`. Listing `21-status-equ-zero` stands in: `STATUS_OK EQU 0` and `STATUS_ERR EQU 1`. It loads `STATUS_OK` into EAX, compares to `STATUS_ERR`, and because 0 is not 1 it keeps `mov ecx, STATUS_OK`. Expected exit: **0**. `EQU` also appears in `constants.inc`, in listing `07-debug-equ-exit` (`DEBUG EQU 1`), and in listing `18-offset-equ` (`MSG_LEN EQU msg_end - msg`).

```asm
; Listing 21: EQU constants choose process status (01-* topic)
; Expected exit: 0
; Expected stdout: (none)

STATUS_OK EQU 0
STATUS_ERR EQU 1

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     eax, STATUS_OK
    cmp     eax, STATUS_ERR
    je      use_err
    mov     ecx, STATUS_OK
    jmp     done
use_err:
    mov     ecx, STATUS_ERR
done:
    call    ExitProcess
main ENDP
END
```

`IFDEF` tests whether a symbol exists, not what it equals. Listing `07-debug-equ-exit` defines `DEBUG EQU 1`, then keeps the `IFDEF DEBUG` branch. That branch loads `1` into ECX. The `ELSE` branch (`xor ecx, ecx`) is discarded before encoding. The procedure is `main PROC FRAME` with `sub rsp, 32` / `.allocstack 32` / `.endprolog` — 32 bytes of shadow space before `call ExitProcess`. Expected exit: **1**.

```asm
; Listing 07: DEBUG EQU and IFDEF exit branch (LESSON.md block 7)
;
; Purpose: Conditional assembly picks exit code when DEBUG is defined.
; Expected exit: 1
; Expected stdout: (none)

DEBUG EQU 1

.CODE
EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    IFDEF DEBUG
        mov ecx, 1
    ELSE
        xor ecx, ecx
    ENDIF
    call ExitProcess
main ENDP

END

```

### Text substitution with TEXTEQU

`TEXTEQU` is token-level text replacement. The right-hand side uses angle brackets `<...>` when you substitute more than one token. It is the wrong tool for a numeric constant (`EQU` is clearer) and the right tool for pasting a fragment of syntax.

Listing `23-textequ-exit` binds `EXIT_WITH_42` to the tokens `mov rcx, 42`. Invoking the name pastes that instruction, then `call ExitProcess`. Expected exit: **42**. This is not `EQU 42` followed by `mov ecx, EXIT_WITH_42` — `TEXTEQU` pastes the whole `mov`.

```asm
; Listing 23: TEXTEQU token paste for exit sequence
; Expected exit: 42
; Expected stdout: (none)

EXIT_WITH_42 TEXTEQU <mov rcx, 42>

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    EXIT_WITH_42
    call    ExitProcess
main ENDP
END
```

### Parameterized text with MACRO

A macro is a named template. You declare named parameters (not NASM-style `%1`). At each invocation MASM pastes the argument text into the body and assembles the result. Arguments are not evaluated as expressions before substitution.

Listing `19-exit-with-macro` defines `EXIT_WITH` with one parameter `code`. The expansion is `mov rcx, code` then `call ExitProcess`. Invoking `EXIT_WITH rax` therefore exits with whatever RAX holds. That file is a driver: it calls `add_two_numbers` from a second object (listing `20-add-two-numbers`) and is quoted in the worked example below.

Listing `04-multi-param-macro` defines `Add3` with four named parameters: destination register, then three values. `Add3 rax, 10, 20, 12` pastes into `mov rax, 10` / `add rax, 20` / `add rax, 12`, so RAX is 42. `mov ecx, eax` then `call ExitProcess` makes the process status 42. This listing does not allocate shadow space. Expected exit: **42**.

```asm
; 04-multi-param-macro.asm
;
; Purpose: Demonstrate macro with multiple parameters
; Expected exit code: 42
; Expected stdout: (none)
;
; MASM macros can have multiple named parameters.

.CODE

EXTRN ExitProcess:PROC

; Macro to add three values
Add3 MACRO reg, val1, val2, val3
    mov     reg, val1
    add     reg, val2
    add     reg, val3
ENDM

main PROC
    sub rsp, 40
    Add3 rax, 10, 20, 12    ; RAX = 10 + 20 + 12 = 42
    
    mov     ecx, eax
    call    ExitProcess     ; Exit with 42
main ENDP

END
```

## Assembly-time loops and conditionals

### REPT / REPEAT for code generation

`REPT N` (also spelled `REPEAT N`) copies its body `N` times at assembly time and closes with `ENDM`. The object file contains `N` separate instructions. The CPU does not see a loop, a counter, or a branch.

Listing `03-rept-repetition` clears EAX, then `REPT 3` / `inc eax` / `ENDM`. Three `inc eax` instructions run. EAX is 3. `mov ecx, eax` / `call ExitProcess` exits 3. No `FRAME`, no `sub rsp`. Expected exit: **3**.

```asm
; 03-rept-repetition.asm
;
; Purpose: Demonstrate REPT for compile-time repetition
; Expected exit code: 3
; Expected stdout: (none)
;
; REPT (equivalent to NASM %rep) generates code at assembly time.
; The CPU executes N separate instructions, not a runtime loop.

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    xor     eax, eax
    
    ; Generate three INC instructions at assembly time
    REPT 3
    inc     eax
    ENDM
    
    ; EAX = 3
    mov     ecx, eax
    call    ExitProcess     ; Exit with 3
main ENDP

END
```

### Preprocessor variables with `=`

`=` defines a reassignable assemble-time symbol. MASM does not give you NASM's `%assign` iterator inside `REPT`. For numbered labels, use `LOCAL` or write the copies out.

Listing `24-rept-counter-assign` zeros RCX, sets `i = 0`, then `REPT 4` expands `inc rcx` and `i = i + 1` four times. The four `inc rcx` instructions run; RCX is 4 when `ExitProcess` is called (RCX is already the status). `i` lives only at assemble time — it is not a register and does not appear in the object. Expected exit: **4**.

```asm
; Listing 24: = reassignment inside REPT (LESSON.md)
; Expected exit: 4
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    xor     rcx, rcx
    i = 0
    REPT 4
        inc     rcx
        i = i + 1
    ENDM
    call    ExitProcess
main ENDP
END
```

### IFDEF and ELSE

`IFDEF SYMBOL` keeps a block only when `SYMBOL` is already defined. `IFNDEF`, `IF`, `ELSEIF`, `IFB`, `IFNB`, `ELSE`, and `ENDIF` are the rest of the family. The inactive branch is deleted before encoding; the CPU sees one path.

Listing `06-conditional-assembly` has `DEBUG = 1` commented out. `IFDEF DEBUG` is false, so the listing keeps `xor ecx, ecx` and discards `mov ecx, 1`. Expected exit: **0**. Uncomment `DEBUG = 1` and the same source exits 1 — that is what listing `07-debug-equ-exit` already does with `DEBUG EQU 1`.

```asm
; 06-conditional-assembly.asm
;
; Purpose: Demonstrate conditional assembly with IF/IFDEF
; Expected exit code: 0
; Expected stdout: (none)
;
; MASM uses IF, IFDEF, IFNDEF, ELSE, ENDIF for conditional assembly.
; To enable DEBUG, uncomment the DEBUG = 1 line.

; Uncomment to enable debug mode:
; DEBUG = 1

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    IFDEF DEBUG
        mov     ecx, 1      ; Debug exit code
    ELSE
        xor     ecx, ecx    ; Release exit code
    ENDIF
    
    call    ExitProcess
main ENDP

END
```

## Macro-local labels with LOCAL

A label declared `LOCAL` inside a macro is rewritten to a unique name on every expansion (`??0000`, `??0001`, …). Without `LOCAL`, a second invocation in the same module redefines the label and `ml64` reports A2005.

`LOCAL` must appear at the start of the macro body, before instructions. Several names can share one `LOCAL` line, separated by commas.

### A label without LOCAL

Listing `08-macro-label-redefine` defines `TWICE` with a bare `skip_label:` and invokes it **once**. One expansion assembles. A second `TWICE` in the same `main` would fail `ml64` with A2005. The body does `inc rdi` after `xor rdi, rdi`, then `mov ecx, edi` / `call ExitProcess`. The procedure is `FRAME` with `sub rsp, 32`. Expected exit: **1**.

```asm
; Listing 08: Macro without LOCAL reuses label (LESSON.md block 8)
;
; Purpose: One expansion works; a second TWICE in the same file would fail ml64 (A2005).
; Expected exit: 1
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

TWICE MACRO
skip_label:
    inc rdi
ENDM

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    xor rdi, rdi
    TWICE
    mov ecx, edi
    call ExitProcess
main ENDP

END

```

### The same macro with LOCAL, invoked twice

Listing `09-twice-macro-local` adds `LOCAL skip_label` and invokes `TWICE` twice. Each expansion gets its own label. RDI increments twice. Expected exit: **2**.

RDI is nonvolatile in the Microsoft x64 ABI. This `main` is a process entry that calls `ExitProcess` instead of returning, so it never has to restore RDI for a caller.

```asm
; Listing 09: TWICE macro with LOCAL labels (LESSON.md block 9)
;
; Purpose: Each macro expansion gets a unique label; two calls increment rdi twice.
; Expected exit: 2
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

TWICE MACRO
    LOCAL skip_label
skip_label:
    inc rdi
ENDM

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    xor rdi, rdi
    TWICE
    TWICE
    mov ecx, edi
    call ExitProcess
main ENDP

END

```

### Absolute value: two expansions, two unique branch targets

Listing `02-macro-with-local` defines `AbsValue` with `LOCAL skip_neg`. The body is `cmp reg, 0` / `jge skip_neg` / `neg reg` / `skip_neg:`. `main` does `AbsValue rax` on −9, then `AbsValue rbx` on −5. The process status is the absolute value of −9: `mov ecx, eax` after the first register is already non-negative. No `FRAME`. Expected exit: **9**.

```asm
; 02-macro-with-local.asm
;
; Purpose: Demonstrate LOCAL directive for macro-local labels
; Expected exit code: 9
; Expected stdout: (none)
;
; LOCAL creates unique labels for each macro invocation,
; equivalent to NASM's %%label.

.CODE

EXTRN ExitProcess:PROC

; Macro to compute absolute value
AbsValue MACRO reg
    LOCAL skip_neg
    cmp     reg, 0
    jge     skip_neg
    neg     reg
skip_neg:
ENDM

main PROC
    sub rsp, 40
    mov     rax, -9
    AbsValue rax            ; First invocation uses unique skip_neg
    mov     rbx, -5
    AbsValue rbx            ; Second invocation uses different skip_neg
    
    ; Exit with absolute value of -9 (= 9)
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
```

Listing `10-abs-macro-local` is the same algorithm under the name `ABS` with `LOCAL ok_label`, applied once to RDI = −9. `FRAME`, `sub rsp, 32`. `mov ecx, edi` / `call ExitProcess`. Expected exit: **9**.

```asm
; Listing 10: ABS macro with LOCAL ok_label (LESSON.md block 10)
;
; Purpose: Absolute value via compare/neg with a unique branch label per expansion.
; Expected exit: 9
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

ABS MACRO reg
    LOCAL ok_label
    cmp reg, 0
    jge ok_label
    neg reg
ok_label:
ENDM

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    mov rdi, -9
    ABS rdi
    mov ecx, edi
    call ExitProcess
main ENDP

END

```

### Several LOCAL names on one line

Listing `11-macro-local-list` declares `LOCAL label1, label2, label3` and never references those names. The body is `inc rcx`. Two invocations would leave RCX = 2, but the listing then executes `mov ecx, 2` and exits with that immediate. The LOCAL list is the point; the increments do not determine the status. `FRAME`, `sub rsp, 32`. Expected exit: **2**.

```asm
; Listing 11: LOCAL label list in a macro (LESSON.md block 11)
;
; Purpose: Declare multiple LOCAL symbols; body increments a register once per expansion.
; Expected exit: 2
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

MACRO_NAME MACRO
    LOCAL label1, label2, label3
    inc rcx
ENDM

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    xor rcx, rcx
    MACRO_NAME
    MACRO_NAME
    mov ecx, 2
    call ExitProcess
main ENDP

END

```

## INCLUDE for shared headers

`INCLUDE file.inc` (quotes optional) pastes that file at the current line. Headers hold `EQU` values, macros, and structures. The include-guard idiom is `IFNDEF` / `EQU` / `ENDIF`: a second inclusion sees the guard symbol and skips the body, so you do not get duplicate definitions.

There is still no `12-*.asm`. Listing `22-exit-code-include` plus `22-exit-code.inc` stand in. The header guards on `EXIT_CODE_INC` and defines `EXIT_OK EQU 0`. The `.asm` starts with `INCLUDE 22-exit-code.inc` and exits `EXIT_OK`. Expected exit: **0**. Assemble from the listings directory so the `INCLUDE` path resolves. `constants.inc` (consumed by listing `13-stdio-constants-include`) is the other shared header.

```asm
IFNDEF EXIT_CODE_INC
EXIT_CODE_INC EQU 1
EXIT_OK EQU 0
ENDIF
```

```asm
; Listing 22: INCLUDE shared header (12-* topic; pairs with 22-exit-code.inc)
; Expected exit: 0
; Expected stdout: (none)

INCLUDE 22-exit-code.inc

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     ecx, EXIT_OK
    call    ExitProcess
main ENDP
END
```

`constants.inc` guards on `CONSTANTS_INC`, then defines `STD_OUTPUT_HANDLE EQU -11`, `STD_INPUT_HANDLE EQU -10`, `GENERIC_READ EQU 80000000h`, and `GENERIC_WRITE EQU 40000000h`.

```asm
; Shared Win32 constants for macro/include listings (LESSON.md block 12)
IFNDEF CONSTANTS_INC
CONSTANTS_INC EQU 1

STD_OUTPUT_HANDLE EQU -11
STD_INPUT_HANDLE EQU -10
GENERIC_READ EQU 80000000h
GENERIC_WRITE EQU 40000000h

ENDIF

```

Listing `13-stdio-constants-include` starts with `INCLUDE constants.inc`. It writes `"ok"` plus CR LF (`13, 10`) to standard output: `GetStdHandle` with `STD_OUTPUT_HANDLE` in ECX, HANDLE saved in RBX, then `WriteFile` with `lea rdx, line`, `mov r8d, line_len`, `lea r9, written`, and a NULL overlapped pointer at `QWORD PTR [rsp+32]`. The frame is `push rbx` / `.pushreg rbx` / `sub rsp, 48` / `.allocstack 48`. Expected exit: **0**. Expected stdout: `ok` and a CRLF.

Build it from the listings directory so `INCLUDE constants.inc` resolves:

```bat
ml64 /c /Fo13-stdio-constants-include.obj 13-stdio-constants-include.asm
link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:13-stdio-constants-include.exe 13-stdio-constants-include.obj kernel32.lib
```

```asm
; Listing 13: INCLUDE constants.inc for STD_OUTPUT_HANDLE (LESSON.md block 13)
;
; Purpose: Shared constants in an include file; write "ok" to stdout.
; Expected exit: 0
; Expected stdout: "ok\n"
;
; Build from listings dir:
; ml64 /c /Fo13-stdio-constants-include.obj 13-stdio-constants-include.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:13-stdio-constants-include.exe 13-stdio-constants-include.obj kernel32.lib

INCLUDE constants.inc

.DATA
line BYTE "ok", 13, 10
line_len EQU $ - line

.DATA?
written DWORD ?

.CODE
EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push rbx
    .pushreg rbx
    sub rsp, 48
    .allocstack 48
    .endprolog

    mov ecx, STD_OUTPUT_HANDLE
    call GetStdHandle
    mov rbx, rax

    mov rcx, rbx
    lea rdx, line
    mov r8d, line_len
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile

    xor ecx, ecx
    call ExitProcess
main ENDP

END
```

## Splitting across multiple files

When a program grows, you put the entry point in one file, helpers in another, data in a third. The defining file **exports** with `PUBLIC` (procedures you write with `PROC` are typically exported as well). The using file **imports** with `EXTRN symbol:type`. You must write the type: `:PROC` for a procedure, `:QWORD` for an 8-byte datum, `:BYTE` for a byte array. Assemble each file with `ml64 /c`, then pass every `.obj` to `link`.

A missing definition is a link error ("unresolved external symbol"), not a runtime NULL. `EXTRN` in the file that **defines** the symbol is wrong: that file already has the `PROC` or the `PUBLIC` label.

### Object-only helper and its driver

Listing `05-multifile-helper` is not an executable. It has no `main` and no `ExitProcess`. It exports `add_two_numbers` with `PUBLIC add_two_numbers`. The procedure reads the first two Microsoft x64 arguments from RCX and RDX, writes RCX+RDX into RAX, and `ret`s.

```asm
; 05-multifile-helper.asm
;
; Purpose: Helper file for multi-file project demo
;
; Exports add_two_numbers function.
; This file is linked with 05-multifile-main.asm.

.CODE

; Export (PUBLIC in MASM, equivalent to NASM global)
PUBLIC add_two_numbers

add_two_numbers PROC
    ; MS x64 calling convention: RCX, RDX are first two args
    mov     rax, rcx
    add     rax, rdx
    ret
add_two_numbers ENDP

END
```

Listing `05-multifile-main` is the driver. It imports `add_two_numbers:PROC` and `ExitProcess:PROC`, allocates 40 bytes (shadow plus alignment; zero pushes at the first `call`), loads RCX = 20 and RDX = 22, calls the helper, and exits with EAX. No `FRAME`. Expected exit: **42**.

```bat
ml64 /c /Fo05-multifile-main.obj 05-multifile-main.asm
ml64 /c /Fo05-multifile-helper.obj 05-multifile-helper.asm
link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:05-multifile.exe 05-multifile-main.obj 05-multifile-helper.obj kernel32.lib
```

```asm
; 05-multifile-main.asm
;
; Purpose: Demonstrate multi-file project (main file)
; Expected exit code: 42
; Expected stdout: (none)
;
; This file calls a helper function defined in another file.
; Build:
;   ml64 /c /Fo05-multifile-main.obj 05-multifile-main.asm
;   ml64 /c /Fo05-multifile-helper.obj 05-multifile-helper.asm
;   link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:05-multifile.exe ^
;        05-multifile-main.obj 05-multifile-helper.obj kernel32.lib

.CODE

EXTRN add_two_numbers:PROC
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     rcx, 20         ; First argument (MS x64 ABI)
    mov     rdx, 22         ; Second argument
    call    add_two_numbers ; Returns result in RAX
    
    mov     ecx, eax
    call    ExitProcess     ; Exit with 42
main ENDP

END
```

### helper_add as a link object

Listing `14-helper-add` is another object-only module: `PUBLIC helper_add`, `mov rax, rcx` / `add rax, rdx` / `ret`. Link it with listing `16-main-call-helper`; do not run it alone.

```asm
; Listing 14: helper_add procedure object (LESSON.md block 14)
;
; Link with 16-main-call-helper.asm (same as 05-multifile pattern).

.CODE
PUBLIC helper_add

helper_add PROC
    mov rax, rcx
    add rax, rdx
    ret
helper_add ENDP

END
```

Listing `16-main-call-helper` imports `helper_add:PROC`, uses a `FRAME` with `sub rsp, 40` / `.allocstack 40`, calls with 20 and 22, and exits with EAX. Expected exit: **42**.

```bat
ml64 /c 14-helper-add.asm
ml64 /c 16-main-call-helper.asm
link /ENTRY:main /SUBSYSTEM:CONSOLE 16-main-call-helper.obj 14-helper-add.obj kernel32.lib
```

```asm
; Listing 16: main calls helper_add (LESSON.md block 16)
;
; Expected exit: 42
; Expected stdout: (none)
;
; ml64 /c 14-helper-add.asm && ml64 /c 16-main-call-helper.asm && link ...

.CODE
EXTRN helper_add:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    mov rcx, 20
    mov rdx, 22
    call helper_add
    mov ecx, eax
    call ExitProcess
main ENDP

END
```

### PUBLIC data as a link object

Listing `15-data-message` exports `PUBLIC message` (`BYTE "Hello from data.asm", 0`) and is now a standalone executable: `.CODE`, `main`, `xor ecx, ecx` / `call ExitProcess`. Expected exit: **0**. A second object can still `EXTRN message:BYTE` and link this `.obj`.

```asm
; Listing 15: PUBLIC message in data module (LESSON.md block 15)
;
; Assembles standalone; message is exported for multifile demos.
; Expected exit: 0

.DATA
PUBLIC message
message BYTE "Hello from data.asm", 0

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub     rsp, 40
    xor     ecx, ecx
    call    ExitProcess
main ENDP

END
```

### add_two_numbers as a link object

Listing `20-add-two-numbers` is the object-only `add_two_numbers` used by listing `19-exit-with-macro` (and the same symbol listing `05-multifile-helper` already exported). Quote is in the worked example.

## Automatic RIP-relative addressing in MASM x64

`ml64` encodes a data label in a memory operand as RIP-relative. You do not write NASM's `default rel` or `[rel symbol]`. `lea rdx, msg` is the usual way to put that address in a register.

Listing `17-writefile-rip-relative` writes `"hi"` plus a single LF (`10`, not CR LF) to standard output. `GetStdHandle` is called with ECX = −11 (`STD_OUTPUT_HANDLE`). The HANDLE goes in RBX. `WriteFile` uses `lea rdx, msg`, `mov r8, msg_len` (64-bit, not `r8d`), `lea r9, written`, and a NULL overlapped QWORD at `[rsp+32]`. Frame: `push rbx` / `sub rsp, 48`. Expected exit: **0**. Expected stdout: `hi` and a line feed.

The listing places `EXTRN` under `.CODE`, then switches to `.DATA` / `.DATA?`, then defines `main PROC` without a second `.CODE`. That is the source as written.

```asm
; Listing 17: WriteFile with RIP-relative msg (LESSON.md block 17)
;
; Expected exit: 0
; Expected stdout: "hi\n"

INCLUDE constants.inc

.DATA
msg BYTE "hi", 13, 10
msg_len EQU $ - msg

.DATA?
written DWORD ?

.CODE
EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push rbx
    .pushreg rbx
    sub rsp, 48
    .allocstack 48
    .endprolog

    mov ecx, STD_OUTPUT_HANDLE
    call GetStdHandle
    mov rbx, rax

    mov rcx, rbx
    lea rdx, msg
    mov r8d, msg_len
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile

    xor ecx, ecx
    call ExitProcess
main ENDP

END
```

`OFFSET` computes an address at assembly time rather than loading it with `lea`. Listing `18-offset-equ` puts `"Z", 0` in `.DATA`, marks `msg_end LABEL BYTE` after it, and binds `MSG_LEN EQU msg_end - msg` (2). It takes the address two ways — `lea rcx, msg` (RIP-relative) and `mov rdx, OFFSET msg` (64-bit immediate) — then checks that a runtime `lea`/`sub` span equals `MSG_LEN` and that the two addresses match. Success exits **2** (`MSG_LEN`). Span mismatch exits **117**; LEA vs OFFSET mismatch exits **118**. Frame: `PROC FRAME`, `sub rsp, 40`.

```asm
; Listing 18: OFFSET / label span (LESSON.md block 18)
;
; Purpose: RIP-relative LEA vs OFFSET immediate; assemble-time span MSG_LEN.
; Expected exit: 2
; Expected stdout: (none)
;
; MSG_LEN = msg_end - msg (same .DATA section). Runtime span must match.
; Failure codes: 117 = span mismatch, 118 = LEA vs OFFSET address mismatch.

.DATA
msg BYTE "Z", 0
msg_end LABEL BYTE

MSG_LEN EQU msg_end - msg
FAIL_SPAN_CODE EQU 117
FAIL_ADDR_CODE EQU 118

.CODE
EXTRN ExitProcess:PROC

main PROC FRAME
    sub     rsp, 40
    .allocstack 40
    .endprolog

    ; Two legal ways to take the address of msg in MASM x64:
    lea     rcx, msg                 ; RIP-relative
    mov     rdx, OFFSET msg          ; 64-bit immediate (ADDR64)

    lea     rax, msg
    lea     rbx, msg_end
    sub     rbx, rax
    cmp     ebx, MSG_LEN
    jne     fail_span_exit

    cmp     rcx, rdx
    jne     fail_addr_exit

    mov     ecx, MSG_LEN
    call    ExitProcess

fail_span_exit:
    mov     ecx, FAIL_SPAN_CODE
    call    ExitProcess

fail_addr_exit:
    mov     ecx, FAIL_ADDR_CODE
    call    ExitProcess
main ENDP

END
```

## NMake: rebuilding only what changed

A Makefile (often `Makefile.mak` for NMake) names targets, prerequisites, and recipes. NMake compares timestamps and rebuilds only what is out of date. NMake ships with Visual Studio.

Listing `25-nmake-driver` is the program the sample makefile builds: `xor ecx, ecx` / `call ExitProcess`. Expected exit: **0**. `Makefile.mak` in the same listings directory is the NMake file: target `25-nmake-driver.exe` depends on `25-nmake-driver.obj`; an inference rule `.asm.obj:` runs `ml64 /c $<`; the link line uses `$**` and `$@`.

```asm
; Listing 25: Program built via NMake (see Makefile.mak in this directory)
; Expected exit: 0
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    xor     ecx, ecx
    call    ExitProcess
main ENDP
END
```

```makefile
# Sample NMake file for listing 25-nmake-driver.asm
# nmake /f Makefile.mak

all: 25-nmake-driver.exe

25-nmake-driver.exe: 25-nmake-driver.obj
	link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:$@ $** kernel32.lib

.asm.obj:
	ml64 /c $<
```

A recipe line must start with a hard tab, not spaces.

An inference rule builds any `.obj` from a `.asm`:

```makefile
.asm.obj:
	ml64 /c $<
```

`$<` is the source (`file.asm`). The target is the matching `.obj`. NMake writes `.source_ext.target_ext:` rather than GNU Make's `%.obj: %.asm`.

A link rule:

```makefile
prog.exe: main.obj helper.obj
	link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:$@ $** kernel32.lib
```

`$**` is every prerequisite. `$@` is the target. `$<` is only the **first** prerequisite — using `$<` on the link line drops `helper.obj` and you get unresolved externals.

NMake has no `.PHONY`. `all` and `clean` work as long as no file has that name:

```makefile
# Makefile.mak
# nmake /f Makefile.mak

all: prog.exe

prog.exe: main.obj helper.obj
	link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:$@ $** kernel32.lib

.asm.obj:
	ml64 /c $<

clean:
	del /Q *.obj prog.exe 2>nul
```

If `main.asm` changes, NMake reassembles `main.obj` and relinks `prog.exe`. Unchanged `helper.asm` keeps its `.obj`.

A PowerShell script can do the same timestamp check without NMake:

```powershell
# build.ps1
$sources = @("main.asm", "helper.asm")
$objects = @()

foreach ($src in $sources) {
    $obj = $src -replace '\.asm$', '.obj'
    if (!(Test-Path $obj) -or (Get-Item $src).LastWriteTime -gt (Get-Item $obj).LastWriteTime) {
        Write-Host "Assembling $src..."
        ml64 /c $src
        if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
    }
    $objects += $obj
}

Write-Host "Linking prog.exe..."
link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:prog.exe $objects kernel32.lib
```

```powershell
powershell -ExecutionPolicy Bypass -File build.ps1
```

## Worked example: two-file add with EXIT_WITH

**Task:** Split the program across `19-exit-with-macro.asm` and `20-add-two-numbers.asm`. The driver calls `add_two_numbers` with 20 and 22. A macro `EXIT_WITH` wraps `ExitProcess`. Exit with the sum.

**Reasoning:**

1. The helper object exports `PUBLIC add_two_numbers`. It is not an executable: no `main`, no `ExitProcess`. RCX and RDX are the first two arguments; RAX is the return.
2. The driver imports `add_two_numbers:PROC` and `ExitProcess:PROC`. `EXIT_WITH code` expands to `mov rcx, code` / `call ExitProcess`.
3. `main PROC FRAME` allocates 32 bytes of shadow space and never restores RSP — `ExitProcess` terminates the process. There is no `add rsp, 32` before the macro.
4. `call add_two_numbers` leaves 42 in RAX. `EXIT_WITH rax` pastes `mov rcx, rax`, so the status is 42.
5. Build with two `ml64 /c` lines and one `link` of both objects plus `kernel32.lib`.

```bat
ml64 /c 20-add-two-numbers.asm
ml64 /c 19-exit-with-macro.asm
link /ENTRY:main /SUBSYSTEM:CONSOLE 19-exit-with-macro.obj 20-add-two-numbers.obj kernel32.lib
```

```asm
; Listing 19: EXIT_WITH macro after add_two_numbers (LESSON.md block 19)
;
; Expected exit: 42
; Expected stdout: (none)
;
; ml64 /c 20-add-two-numbers.asm && ml64 /c 19-exit-with-macro.asm && link ...

.CODE
EXTRN add_two_numbers:PROC
EXTRN ExitProcess:PROC

EXIT_WITH MACRO code
    mov rcx, code
    call ExitProcess
ENDM

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    mov rcx, 20
    mov rdx, 22
    call add_two_numbers
    EXIT_WITH rax
main ENDP

END
```

```asm
; Listing 20: add_two_numbers procedure (LESSON.md block 20)
;
; Link with 19-exit-with-macro.asm or 05-multifile-main.asm.

.CODE
PUBLIC add_two_numbers

add_two_numbers PROC
    mov rax, rcx
    add rax, rdx
    ret
add_two_numbers ENDP

END
```

Expected exit: **42** (`echo %ERRORLEVEL%`).

### A plausible wrong reading (and why it fails)

*"I should put `EXTRN add_two_numbers:PROC` in the helper file too, so both objects agree on the name."*

`EXTRN` means "defined in another object; emit a relocation." Listing `20-add-two-numbers` **defines** the procedure. The definition (`PROC` / `PUBLIC`) and an `EXTRN` for the same name in that file are mutually exclusive. Mark it `EXTRN` where it is defined and the linker reports an unresolved external. Import in the driver (listing `19-exit-with-macro`). Export in the helper.

## Distinctions worth keeping straight

| Confusion | Reality |
|-----------|---------|
| `TEXTEQU` is `EQU` | `TEXTEQU` pastes tokens. `EQU` binds a numeric or address constant. Listing `23-textequ-exit` pastes `mov rcx, 42` and exits **42**. `DEBUG EQU 1` and `STD_OUTPUT_HANDLE EQU -11` are `EQU` |
| A macro argument is evaluated, then substituted | The argument text is pasted, then assembled. `EXIT_WITH rax` becomes `mov rcx, rax`, not `mov rcx, 42` computed by the macro processor |
| `REPT 3` is a runtime loop | Listing `03-rept-repetition` emits three `inc eax` instructions. EAX ends at 3 with no branch |
| A descriptive label inside a macro is enough | Without `LOCAL`, a second expansion is A2005. Listing `08-macro-label-redefine` invokes `TWICE` once so it still assembles; listing `09-twice-macro-local` invokes it twice with `LOCAL` |
| `EXTRN` exports a symbol | `EXTRN` **imports**. `PUBLIC` (and the `PROC` in the defining file) exports. Listings `05-multifile-helper`, `14-helper-add`, and `20-add-two-numbers` are the export side |
| `ml64` accepts several `.asm` files at once | One `ml64 /c` per source. Several `.obj` files go to `link` |
| `$<` on the link line is "all objects" | `$<` is the first prerequisite. Use `$**` for every `.obj` |
| `EXTRN symbol` without a type | The type (`:PROC`, `:QWORD`, `:BYTE`, …) is required |
| NASM `%1` / `%%label` / `%rep` | MASM uses named macro parameters, `LOCAL`, and `REPT`/`ENDM` |
| Linux `syscall` / `nasm -f elf64` | These programs are `ml64` / `link /ENTRY:main /SUBSYSTEM:CONSOLE` and `call ExitProcess` |

## Check yourself

1. Listing `08-macro-label-redefine` invokes `TWICE` once and exits 1. What does `ml64` report if you add a second `TWICE` in the same `main` without `LOCAL`? What does listing `09-twice-macro-local` change, and what is its exit status?
2. Listing `05-multifile-helper` has `PUBLIC add_two_numbers` and no `main`. Can you `link /ENTRY:main` that object by itself? What second object do you have to pass, and which file contains the `EXTRN`?
3. An NMake rule is `prog.exe: main.obj helper.obj` with recipe `link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:$@ $< kernel32.lib`. What does `$<` expand to, and which automatic variable lists both objects?
4. Listing `07-debug-equ-exit` defines `DEBUG EQU 1` and listing `06-conditional-assembly` leaves `DEBUG = 1` commented out. What process status does each program produce, and which assemble-time branch is kept?
5. After `REPT 3` / `inc eax` / `ENDM` in listing `03-rept-repetition`, how many `inc eax` instructions are in the object, and how many times does EAX increment when the program runs?

## Key takeaways

- `EQU` binds a constant; `MACRO` pastes parameterized instructions; `REPT` duplicates a body at assembly time. None of those directives exist at run time. Listing `21-status-equ-zero` exits **0** from `STATUS_OK`. Listing `24-rept-counter-assign` increments RCX four times (`i = i + 1` is assemble-time only) and exits **4**. Listing `23-textequ-exit` pastes `mov rcx, 42` and exits **42**.
- A label inside a macro needs `LOCAL` or a second expansion is A2005. Listing `09-twice-macro-local` exits 2; listing `02-macro-with-local` applies `AbsValue` twice and exits 9.
- `PUBLIC` / `PROC` export; `EXTRN name:type` imports. Helper listings `05-multifile-helper`, `14-helper-add`, and `20-add-two-numbers` have no `main` — you link them with a driver. Listing `15-data-message` still exports `message` and now has a `main` that exits **0**.
- `ml64 /c` builds one object; `link /ENTRY:main /SUBSYSTEM:CONSOLE` combines objects and `kernel32.lib`. A missing `EXTRN` definition is a link error.
- `INCLUDE` pastes a header. Listing `22-exit-code-include` pulls `EXIT_OK EQU 0` from `22-exit-code.inc` and exits **0**. `constants.inc` supplies `STD_OUTPUT_HANDLE EQU -11`; listing `13-stdio-constants-include` uses it and writes `ok` plus CRLF.
- `lea rdx, msg` is RIP-relative in `ml64` without a `default rel` directive (listing `17-writefile-rip-relative`).
- NMake inference rules rebuild a stale `.obj`; `$**` is all prerequisites, `$<` is only the first. Listing `25-nmake-driver` exits **0**; `Makefile.mak` links it with `$**` / `$@`.

## Lookup

- MASM reference: [Microsoft Macro Assembler Reference](https://learn.microsoft.com/en-us/cpp/assembler/masm/microsoft-macro-assembler-reference)
- Macros: [MACRO](https://learn.microsoft.com/en-us/cpp/assembler/masm/macro), [LOCAL](https://learn.microsoft.com/en-us/cpp/assembler/masm/local-masm)
- Symbols: [PUBLIC](https://learn.microsoft.com/en-us/cpp/assembler/masm/public-masm), [EXTERN](https://learn.microsoft.com/en-us/cpp/assembler/masm/extern-masm)
- NMake: [NMake Reference](https://learn.microsoft.com/en-us/cpp/build/reference/nmake-reference), [Macros and NMake](https://learn.microsoft.com/en-us/cpp/build/reference/macros-and-nmake)
- RIP-relative `lea` and the Microsoft x64 ABI: [x64 calling convention](https://learn.microsoft.com/en-us/cpp/build/x64-calling-convention)

## Exercises

Twenty-four drills under `exercises/`. Solutions mirror the names under `solutions/`. Build from an x64 Native Tools Command Prompt:

```bat
ml64 /c FILE.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE FILE.obj kernel32.lib && FILE.exe
```

Multi-file drills still assemble one source per `ml64 /c` and pass every `.obj` to `link`.

The exercises use the MASM directives this lesson quotes.

**Macros:** `STATUS_OK EQU 0`, exit 0. `exit_with 7`, exit 7. A write macro that prints `M` plus CRLF, exit 0. `IFNDEF` guard, exit 42. `REPEAT 3` with `inc rdi`, exit 3. `ADD_IMM rdi, 2` after `mov rdi, 40`, exit 42. Push `rbx` and `r12`, pop in reverse, exit 5. Zero-argument `CALL_EXIT`, exit 0. Four `inc rdi` from `REPEAT 4`, exit 4. `TWICE` with `LOCAL`, two increments, exit 2. `IFDEF DEBUG` keeps `mov ecx, 1`, exit 1. `VERSION EQU 3`, exit 3. Store `"Q"` plus CRLF, exit 0. RIP-relative `lea`, exit 0. `ADD3` 10+20+12, exit 42. Supply the missing argument to `EXIT_STATUS`. Stretch: `STD_OUTPUT_HANDLE EQU -11`, `WriteFile` of `U` plus CRLF, exit 0. From scratch: `AbsVal` with `LOCAL`, exit 9.

**Multi-file and NMake:** Comment-only multi-file note in a single file, exit 0. Single-file `EXTRN` simulation, exit 5. `PUBLIC` simulation, return 42. NMake phony-target comment, exit 0. `EXTRN` declaration without a second object, exit 9. Object count as an immediate, exit 3.

Expected exits are in each file header under `exercises/` (there is no `exercises/09-macros-multifile-make/README.md`).
