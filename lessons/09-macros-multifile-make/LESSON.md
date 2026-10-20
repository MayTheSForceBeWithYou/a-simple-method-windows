# 09 — Macros, Multi-file, NMake

Every Win32 API call you've written so far spelled out `mov rcx, STATUS` and `call ExitProcess` by hand. This lesson shows you how to collapse that repetition into reusable macros, how to split a program across multiple files that share symbols, and how to automate rebuilds with NMake or PowerShell so you only reassemble what changed. By the end you'll see that assembly—even without a standard library—can still be factored into maintainable, composable units.

## What this lesson asks of you

- Replace repeated magic numbers with `EQU` constants and collapse repetitive instruction sequences into `MACRO` definitions.
- Use `REPEAT` (or manual unrolling) to generate code at assembly time without runtime loops.
- Mark macro-internal labels with `LOCAL` to avoid name collisions across multiple macro invocations.
- Export a symbol with `PUBLIC` (or implicitly via `PROC`) in one file and reference it with `EXTERN` in another, declaring the symbol's type (`:PROC`, `:QWORD`, etc.), then link the two objects into one executable.
- Write NMake pattern rules or PowerShell build scripts that rebuild only changed sources, using inference rules and automatic variables.

## Text substitution with EQU, TEXTEQU, and MACRO

MASM's macro processor runs before the assembler proper. It sees `EQU`, `TEXTEQU`, `MACRO`, `INCLUDE`, and other directives and transforms the source text before any instruction encoding happens.

### Constants with EQU

`EQU` defines a symbol whose value is computed at assembly time. It cannot be redefined later (unlike `=`, which allows reassignment).

```asm
EXTERN ExitProcess:PROC

STATUS_OK EQU 0
STATUS_ERROR EQU 1

.code
main PROC
    sub rsp, 32
    mov rcx, STATUS_OK      ; becomes mov rcx, 0
    call ExitProcess
main ENDP
END
```

`EQU` is similar to NASM's `equ`, but with case-insensitive names by default (MASM convention). Use it for numeric constants, addresses, and expressions.

### Text substitution with TEXTEQU

`TEXTEQU` is token-level text replacement (analogous to NASM's `%define`). The right-hand side must be enclosed in angle brackets `<...>` for multi-token substitution.

```asm
EXIT_OK TEXTEQU <mov rcx, 0>
EXIT_OK TEXTEQU <call ExitProcess>

main PROC
    sub rsp, 32
    EXIT_OK                 ; expands to: mov rcx, 0; call ExitProcess
main ENDP
```

`TEXTEQU` is rarely used for simple constants (where `EQU` is clearer), but it's useful for complex substitutions or conditional assembly.

### Parameterized text with MACRO

A macro is a template for one or more instructions. You declare it with named parameters (or no parameters), and MASM will expand it with the supplied arguments.

```asm
EXTERN ExitProcess:PROC

exit_with MACRO code        ; one parameter: code
    mov rcx, code
    call ExitProcess
ENDM

.code
main PROC
    sub rsp, 32
    exit_with 7             ; expands to: mov rcx, 7; call ExitProcess
main ENDP
END
```

The macro name `exit_with` is followed by the parameter name `code`. Inside the macro body, `code` is replaced by the argument text. Unlike NASM, MASM uses **named parameters**, not `%1`, `%2`, etc.

**Multi-parameter macros:**

```asm
ADD3 MACRO dest, a, b, c
    mov dest, a
    add dest, b
    add dest, c
ENDM

; invocation:
main PROC
    ADD3 rdi, 10, 20, 12    ; rdi = 10 + 20 + 12 = 42
    ; ...
main ENDP
```

Each parameter name is replaced by the corresponding argument text. Arguments are **not evaluated** before substitution—they are pasted as text.

## Assembly-time loops and conditionals

### REPEAT (REPT) for code generation

`REPEAT N` (or `REPT N`) repeats its body `N` times at assembly time. The repetition happens in the MASM macro processor, so the output object contains `N` copies of the instructions, not a loop at runtime.

```asm
EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    xor rdi, rdi
    REPEAT 3
        inc rdi             ; this line appears three times in the output
    ENDM
    mov rcx, rdi            ; rcx = 3
    call ExitProcess
main ENDP
END
```

The code above is equivalent to writing `inc rdi` three times by hand. The CPU executes three separate `inc` instructions—there's no branch, no jump, no loop counter.

**Note:** MASM's `REPEAT` ends with `ENDM`, not `ENDREP`. This is consistent with MASM's use of `ENDM` to close macros, procedures (`ENDP`), and segments (`.code`, `.data` are implicit segments without `ENDS`).

### Preprocessor variables with = (assignment)

MASM has no direct equivalent to NASM's `%assign`. For simple assembly-time iteration, use `=` (reassignable symbol) inside `REPEAT`, but MASM does not support iteration variables inside `REPEAT` the way NASM does. Most code generation is better handled with macros or explicit unrolling.

```asm
i = 0
REPEAT 4
    inc rdi
    i = i + 1               ; MASM may not support this inside REPEAT
ENDM
; i is now 4 (if supported)
```

In practice, `REPEAT` is used for simple repetition, not complex iteration. For numbered label generation, use macro parameters or explicit unrolling.

### IFDEF and ELSE

`IFDEF SYMBOL` checks whether a symbol is defined at assembly time. This is useful for debug switches and conditional compilation.

```asm
DEBUG EQU 1                 ; define DEBUG

.code
main PROC
    sub rsp, 32
IFDEF DEBUG
    mov rcx, 1              ; debug exit
ELSE
    mov rcx, 0              ; release exit
ENDIF
    call ExitProcess
main ENDP
```

If you remove the `DEBUG EQU 1` line (or comment it out), the `ELSE` branch is kept. The CPU sees only one of the two paths—the other is discarded before assembly.

**Note:** MASM uses `IFDEF` (not `%ifdef`), and `ENDIF` (not `%endif`). MASM also supports `IF`, `ELSEIF`, `IFB` (if blank), `IFNB` (if not blank), and other conditional directives.

## Macro-local labels with LOCAL

A label declared with `LOCAL` inside a macro is **macro-local**. MASM generates a unique name for it on every macro expansion, so you can safely use the same label name in multiple invocations without collision.

Without `LOCAL`, a macro containing a label would break if invoked twice in the same function:

```asm
; BAD: second invocation redefines skip_label
TWICE MACRO
skip_label:                 ; ERROR: second invocation redefines skip_label
    inc rdi
ENDM

main PROC
    TWICE                   ; expands skip_label
    TWICE                   ; ERROR: skip_label already defined
main ENDP
```

With `LOCAL`, each invocation gets a unique label:

```asm
TWICE MACRO
    LOCAL skip_label
skip_label:
    inc rdi
ENDM

main PROC
    TWICE                   ; expands to ??0000 (or similar)
    TWICE                   ; expands to ??0001
main ENDP
```

**Example: absolute value macro**

```asm
EXTERN ExitProcess:PROC

ABS MACRO reg
    LOCAL ok_label
    cmp reg, 0
    jge ok_label            ; unique label for this expansion
    neg reg
ok_label:
ENDM

.code
main PROC
    sub rsp, 32
    mov rdi, -9
    ABS rdi                 ; rdi = 9
    mov rcx, rdi
    call ExitProcess
main ENDP
END
```

The `ok_label` is rewritten to something like `??0000` internally, so multiple `ABS` invocations don't collide.

**Important:** The `LOCAL` directive must appear **at the start of the macro body**, before any instructions. You can declare multiple local labels in one `LOCAL` statement, separated by commas:

```asm
MACRO_NAME MACRO
    LOCAL label1, label2, label3
    ; macro body
ENDM
```

## INCLUDE for shared headers

`INCLUDE file.inc` (no quotes required, though they are accepted) inserts the contents of `file.inc` at that line. Header files typically contain `EQU` constants, `MACRO` definitions, and structure definitions.

**Header guard idiom:**

```asm
; constants.inc
IFNDEF CONSTANTS_INC
CONSTANTS_INC EQU 1

; Win32 constants
STD_OUTPUT_HANDLE EQU -11
STD_INPUT_HANDLE EQU -10
GENERIC_READ EQU 80000000h
GENERIC_WRITE EQU 40000000h

ENDIF
```

If two files both `INCLUDE constants.inc`, the second inclusion sees `CONSTANTS_INC` already defined and skips the body, preventing duplicate definitions.

**Usage in a source file:**

```asm
INCLUDE constants.inc

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rcx, STD_OUTPUT_HANDLE  ; -11 from constants.inc
    call GetStdHandle
    ; ...
main ENDP
END
```

## Splitting across multiple files

When a program grows, you want to split it into logical units: one file for the entry point, another for helper routines, another for data structures. To share symbols across files, you must **export** them from the defining file and **import** them in the using file.

### Exporting with PUBLIC (or PROC)

`PUBLIC symbol` marks a symbol (label, function, or data) as visible to other object files. However, functions defined with `PROC` are implicitly public when referenced by `EXTERN` in another file, so explicit `PUBLIC` is often unnecessary for procedures.

```asm
; helper.asm
.code
helper_add PROC             ; implicitly public when used with EXTERN
    mov rax, rcx
    add rax, rdx
    ret
helper_add ENDP
END
```

For data symbols or labels, use explicit `PUBLIC`:

```asm
; data.asm
PUBLIC message

.data
message BYTE "Hello from data.asm", 0
END
```

### Importing with EXTERN

`EXTERN symbol:type` tells MASM that the symbol is defined in another object file. MASM emits a relocation for it; the linker resolves it. **You must specify the type**: `:PROC` for functions, `:QWORD` for 8-byte data, `:BYTE` for byte arrays, etc.

```asm
; main.asm
EXTERN helper_add:PROC      ; import the function (type is :PROC)
EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    
    mov rcx, 20
    mov rdx, 22
    call helper_add         ; rax = 42
    
    mov rcx, rax            ; exit with result
    call ExitProcess
main ENDP
END
```

### Linking multiple objects

Assemble each file separately, then link all objects together (from x64 Native Tools Command Prompt):

```bat
ml64 /c main.asm
ml64 /c helper.asm
link /ENTRY:main /SUBSYSTEM:CONSOLE main.obj helper.obj kernel32.lib
main.exe
echo %ERRORLEVEL%           # 42
```

The linker combines the `.text` (from `.code`), `.data`, and `.rdata` (from `.const`) sections from both objects, resolves `EXTERN` references, and produces a single executable. The entry point is specified by `/ENTRY:main`.

**What if EXTERN has no definition?** The linker will error with "unresolved external symbol `symbol`" at link time, not at assemble time or runtime. This is not a silent null—it's a build failure.

**Important:** Always declare the type of an `EXTERN` symbol. If you omit it, MASM will error: "error A2006: undefined symbol : symbol".

## Automatic RIP-relative addressing in MASM x64

In 64-bit MASM (`ml64`), all references to data symbols are **automatically RIP-relative** by default. You do not need a directive like NASM's `default rel`—MASM assumes RIP-relative addressing for all `[symbol]` references.

```asm
EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

.data
msg BYTE "hi", 10
msg_len EQU $ - msg

.data?
written DWORD ?

.code
main PROC
    sub rsp, 56             ; shadow space + alignment
    
    mov rcx, -11            ; STD_OUTPUT_HANDLE
    call GetStdHandle
    
    mov rcx, rax            ; hFile
    lea rdx, msg            ; RIP-relative (automatic)
    mov r8, msg_len
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    add rsp, 56
    mov rcx, 0
    call ExitProcess
main ENDP
END
```

The `lea rdx, msg` instruction is automatically encoded as RIP-relative: `lea rdx, [rip + offset msg]`. You do **not** write `[rel msg]` (NASM syntax)—MASM does it implicitly.

**When to use OFFSET:** If you want to compute the address at assembly time (not load it into a register), use `OFFSET`:

```asm
MY_ADDR EQU OFFSET msg      ; assembly-time constant
```

In practice, `lea` is preferred for loading addresses into registers, and MASM's automatic RIP-relative addressing makes position-independent code the default.

## NMake: rebuilding only what changed

A Makefile (or `Makefile.mak` for NMake) automates the build: it declares dependencies (which sources produce which objects, which objects link into which binary) and recipes (the shell commands to run). NMake compares file timestamps and rebuilds only what's out of date.

**NMake** is Microsoft's implementation of Make, bundled with Visual Studio. It uses similar syntax to GNU Make but with some differences in built-in rules and macros.

### Basic structure

```makefile
# target: prerequisites
# <tab>recipe
```

The recipe line **must** start with a hard tab, not spaces (same as GNU Make). NMake will error on spaces.

### Inference rules

An inference rule describes how to build any `.obj` from a `.asm`:

```makefile
.asm.obj:
	ml64 /c $<
```

- `$<` is the source file (`file.asm`).
- The target is inferred (`file.obj`).

NMake's inference rules use a different syntax than GNU Make's `%.o: %.asm` pattern rules: `.source_ext.target_ext:` instead of `%.target: %.source`.

### Linking rule

```makefile
prog.exe: main.obj helper.obj
	link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:$@ $** kernel32.lib
```

- `$**` is all prerequisites (`main.obj helper.obj`).
- `$@` is the target (`prog.exe`).

### Phony targets

NMake does not have `.PHONY`, but you can simulate it by using targets that don't produce files:

```makefile
all: prog.exe

clean:
	del /Q *.obj prog.exe 2>nul
```

If a file named `clean` exists, `nmake clean` would see it as up-to-date and do nothing (same as GNU Make). In practice, `clean` and `all` are rarely created as files, so this is not a problem.

### Complete example

```makefile
# Makefile.mak for NMake
# Build with: nmake /f Makefile.mak

all: prog.exe

prog.exe: main.obj helper.obj
	link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:$@ $** kernel32.lib

.asm.obj:
	ml64 /c $<

clean:
	del /Q *.obj prog.exe 2>nul
```

Run `nmake /f Makefile.mak` to build `prog.exe`. Run `nmake /f Makefile.mak clean` to remove build artifacts. If `main.asm` changes, NMake recompiles `main.obj` and relinks `prog.exe`. If `helper.asm` is unchanged, `helper.obj` is not rebuilt.

**Alternative: PowerShell build script**

For simple projects, a PowerShell script may be clearer than NMake:

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

Run with `powershell -ExecutionPolicy Bypass -File build.ps1`.

## Worked example: two-file addition program with macro

**Task:** Write a program split into `main.asm` and `add.asm`. `main.asm` defines `main`, which calls a function `add_two_numbers` exported from `add.asm`. The function adds the first two arguments (`rcx` and `rdx`), returns the result in `rax`. Use a macro `EXIT_WITH` to wrap the `ExitProcess` call. Exit with the sum of 20 and 22.

**Step-by-step reasoning:**

1. **Macro for exit:** Define `EXIT_WITH` with one parameter (status), which allocates shadow space, moves the status to `rcx`, and calls `ExitProcess`.
2. **main.asm:**
   - Define the macro inline (or include it from a header).
   - `EXTERN add_two_numbers:PROC` to import the function.
   - `main PROC`: allocate shadow space, load `rcx = 20`, `rdx = 22`, call `add_two_numbers`, `EXIT_WITH rax`.
3. **add.asm:**
   - Define `add_two_numbers PROC` (implicitly public).
   - `add_two_numbers`: add `rcx, rdx`, move result to `rax`, `ret`.
4. **Build:** `ml64 /c main.asm && ml64 /c add.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE main.obj add.obj kernel32.lib`

**main.asm:**

```asm
EXTERN add_two_numbers:PROC
EXTERN ExitProcess:PROC

EXIT_WITH MACRO code
    mov rcx, code
    call ExitProcess
ENDM

.code
main PROC
    sub rsp, 32             ; shadow space
    
    mov rcx, 20
    mov rdx, 22
    call add_two_numbers    ; rax = 42
    
    add rsp, 32
    EXIT_WITH rax
main ENDP
END
```

**add.asm:**

```asm
.code
add_two_numbers PROC
    mov rax, rcx
    add rax, rdx
    ret
add_two_numbers ENDP
END
```

**Expected output:** Exit status 42 (check with `echo %ERRORLEVEL%` on Windows).

**Plausible wrong reading and why it fails:**

*"I can put `EXTERN add_two_numbers:PROC` in `add.asm` too, so both files know about the function."*

**Why it's wrong:** `EXTERN` means "this symbol is defined elsewhere, resolve it at link time." If you put `EXTERN add_two_numbers:PROC` in `add.asm`, you're telling the assembler that `add_two_numbers` is external to `add.asm`. But `add.asm` is the file that **defines** it with `PROC`. The definition and the `EXTERN` declaration are mutually exclusive: you either define a symbol (`PROC` or `PUBLIC`) or reference it (`EXTERN`), not both. If you mistakenly mark it `EXTERN` in the file that defines it, the linker will fail with "unresolved external symbol `add_two_numbers`."

## Distinctions worth keeping straight

| Confusion | Reality |
|-----------|---------|
| `TEXTEQU` is the same as `EQU` | `TEXTEQU` is text substitution; `EQU` defines a numeric or address constant |
| A macro parameter is evaluated as an expression | Macro parameters are replaced by the exact text of the argument, then assembled as an instruction |
| `REPEAT 3` generates a runtime loop | `REPEAT 3` duplicates the body three times in the source; the CPU sees three straight-line instructions |
| Macro labels can use descriptive names without `LOCAL` | Without `LOCAL`, multiple macro invocations will redefine the label and cause errors |
| `EXTERN` declares a symbol for export | `EXTERN` **imports** a symbol; `PUBLIC` (or `PROC`) exports it |
| You can pass multiple `.asm` files to `ml64` | `ml64` assembles one file per invocation; you pass multiple `.obj` files to `link`, not multiple `.asm` to `ml64` |
| NMake recipes can use spaces for indentation | NMake recipes **must** start with a hard tab; spaces cause syntax errors |
| `EXTERN symbol` works without a type | `EXTERN` requires a type declaration (`:PROC`, `:QWORD`, `:BYTE`, etc.) or MASM will error |

## Check yourself

1. You define `ABS MACRO reg` with a `cmp` and `neg` inside, using a label `done_label`. You invoke `ABS` twice in the same function. What happens at assembly time? How do you fix it?

2. You have `main.asm` with `EXTERN helper:PROC` and `call helper`, and `helper.asm` with a procedure `helper PROC ... ENDP` but no explicit `PUBLIC helper`. Does the linker resolve the symbol, or does it error? Why?

3. Your NMake Makefile has `prog.exe: main.obj helper.obj` with the recipe `link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:$@ $< kernel32.lib`. You run `nmake` and the linker complains about unresolved externals. What does `$<` expand to, and what should you use instead?

4. You write `STATUS_OK EQU 0` and later `mov rcx, STATUS_OK + 1`. Does MASM compute `1`, or does it error?

5. You have `REPEAT 5` with `inc rdi` inside, ending with `ENDM`. After the `ENDM`, how many `inc rdi` instructions are in the assembled object? How many times does `rdi` increment at runtime?

## Key takeaways

- `EQU` defines numeric/address constants; `TEXTEQU` pastes text; `MACRO` pastes parameterized instruction sequences; all happen at assembly time, before encoding.
- `REPEAT` generates code at assembly time; it is not a runtime loop. MASM has no direct equivalent to NASM's `%assign` inside `REPEAT`.
- Macro labels must use `LOCAL` to avoid collisions across multiple invocations; declare `LOCAL` at the start of the macro body.
- `PUBLIC` (or `PROC`) exports a symbol for other files to reference with `EXTERN`; `EXTERN` requires a type declaration (`:PROC`, `:QWORD`, etc.); link multiple `.obj` files with `link`.
- NMake uses inference rules (`.asm.obj:`) and automatic variables (`$@`, `$<`, `$**`) to rebuild only changed files. Alternatively, use PowerShell scripts for more control.
- Recipes must start with a hard tab, not spaces (same as GNU Make).
- MASM automatically uses RIP-relative addressing for data symbols in 64-bit mode; no `default rel` directive needed.

## Lookup

- MASM reference: [Microsoft Macro Assembler Reference](https://learn.microsoft.com/en-us/cpp/assembler/masm/microsoft-macro-assembler-reference)
- MASM macros: [MACRO directive](https://learn.microsoft.com/en-us/cpp/assembler/masm/macro), [LOCAL directive](https://learn.microsoft.com/en-us/cpp/assembler/masm/local-masm)
- MASM symbols: [PUBLIC directive](https://learn.microsoft.com/en-us/cpp/assembler/masm/public-masm), [EXTERN directive](https://learn.microsoft.com/en-us/cpp/assembler/masm/extern-masm)
- NMake: [NMake Reference](https://learn.microsoft.com/en-us/cpp/build/reference/nmake-reference), [Macros and NMake](https://learn.microsoft.com/en-us/cpp/build/reference/macros-and-nmake)

## Standalone listings

These names exist on the listings branch. Prose here keeps LISTING-PENDING until this branch quotes them verbatim.

<!-- LISTING-PENDING: lessons/09-macros-multifile-make/listings/02-macro-with-local.asm -->
<!-- LISTING-PENDING: lessons/09-macros-multifile-make/listings/03-rept-repetition.asm -->
<!-- LISTING-PENDING: lessons/09-macros-multifile-make/listings/04-multi-param-macro.asm -->
<!-- LISTING-PENDING: lessons/09-macros-multifile-make/listings/05-multifile-helper.asm -->
<!-- LISTING-PENDING: lessons/09-macros-multifile-make/listings/05-multifile-main.asm -->
<!-- LISTING-PENDING: lessons/09-macros-multifile-make/listings/06-conditional-assembly.asm -->

## Exercises

Twenty-four drills under `exercises/`. Solutions mirror the names under `solutions/`. Build with (from x64 Native Tools Command Prompt):

```bat
ml64 /c FILE.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE FILE.obj kernel32.lib && FILE.exe
```

The exercises and solutions are written by a separate author and use MASM syntax covered in this lesson. They are organized by category:

**Macros:** Define `STATUS_OK EQU 0`, exit 0. `exit_with 7` macro, exit 7. Macro writes `M\r\n` (CRLF), exit 0. `IFNDEF` / `define` guard, exit 42. `REPEAT 3` with `inc rdi`, exit 3. `ADD_IMM rdi, 2` after `mov rdi, 40`, exit 42. Push `rbx`, `r12`; pop in reverse order, exit 5. Zero-argument `CALL_EXIT` macro, exit 0. `REPEAT 4` with four `inc rdi`, exit 4 (no macro variable). `TWICE` macro with two `inc rdi`, `LOCAL` label, exit 2. `IFDEF DEBUG` keeps `mov rcx, 1`, exit 1. `VERSION EQU 3`, no `INCLUDE` call, exit 3. Stores string `"Q\r\n"`, exit 0 (no stringification). Automatic RIP-relative addressing (no directive needed), exit 0. `ADD3 rdi, 10, 20, 12`, exit 42. Fix: `EXIT_STATUS 4` (supply missing argument).
- `22-stretch-units-header.asm` — `%define SYS_WRITE 1` and `SYS_EXIT 60`, print `U\n`, exit 0
- `24-from-scratch-macro-abs.asm` — `ABS` macro with `%%ok` label, exit 9

**Multi-file and NMake:** Comment mentions multi-file; solution is one file, exit 0. Single file with `EXTERN` simulation, exit 5. Single-file simulation of `PUBLIC`, return 42. Comment about NMake phony targets, exit 0. Single file with `EXTERN` declaration (no external definition), exit 9. Exit 3 (object count as immediate, not NMake graph).

Refer to `exercises/09-macros-multifile-make/README.md` for detailed descriptions and expected exit codes.
