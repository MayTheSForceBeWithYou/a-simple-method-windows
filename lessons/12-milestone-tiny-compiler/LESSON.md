# Lesson 12 — Milestone: Tiny Language Compiler

Lesson 11 gave you tokens, list nodes, a bump cursor, and a three-field AST node. This milestone walks from source text to a result: scan a multi-digit number and a lowercase identifier, fold `(1+2)*3` in registers, then run two different bytecode machines — an accumulator interpreter that exits 30, and a stack interpreter whose stream is `1,4, 1,5, 2, 0`. A third listing shows the register motion of a relative jump and then exits 0.

This is integration, not a new instruction set. You compose the digit test from lesson 11 with `value = value * 10 + digit`, the precedence fact `*` before `+` (and parentheses resetting that), and an explicit instruction pointer that is not RIP.

Every listing is a complete MASM program. Status is ECX to `ExitProcess`. Build from an x64 Native Tools prompt:

```bat
ml64 /c FILE.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE FILE.obj kernel32.lib && FILE.exe
echo %ERRORLEVEL%
```

## What this lesson asks of you

Scan `"42"` by accumulating `value * 10 + digit` until a non-digit (here, the NUL). Scan `"foo"` by counting bytes in `'a'..'z'`. Fold `(1+2)*3` as `add` then `imul`, not `imul` then `add`. Fetch bytecode, dispatch on the opcode, and state honestly what each handler does — listing `04-bytecode-interp` adds the immediate 10 to an accumulator; listing `05-bytecode-stack` pops two stack slots and adds them. Treat a jump listing as the pointer arithmetic it actually performs.

## Why a compiler as milestone 2

A compiler exercises the course so far:

- **Lexing** (lesson 11): classify bytes, then accumulate a number or an identifier.
- **Parsing** (lesson 11): build nodes with kind/left/right; encode precedence in grammar layers.
- **Evaluation or codegen**: walk those nodes, or interpret a byte stream you emitted.
- **Slots**: map names to integer indices (the vector and stack from lesson 11).
- **Control flow**: a relative jump is `ip := ip + displacement` after you have consumed the operand bytes.

The six Jack listings isolate scan, fold, and interpret. The exercises under `exercises/` add `if`, `while`, locals, and PE size bookkeeping. Lesson 13 adds fixed-point; lesson 14 writes pixels.

## Scanning a multi-digit number

Lesson 11's digit test decides whether a byte is `'0'..'9'`. A number token accumulates:

```
value = 0
for each digit d:
    value = value * 10 + d
```

Listing `01-scan-number` does that on `"42"`. RSI walks the string. RDI holds the value. Each iteration zero-extends the byte into RAX, stops on 0, subtracts `'0'`, multiplies RDI by 10, and adds the digit. After `'4'` RDI is 4; after `'2'` RDI is 42; NUL ends the loop. Status **42**.

```asm
; 01-scan-number.asm: Scan multi-digit decimal number, exit with value
; Expected: "42" → exit 42
.DATA
source DB "42", 0
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    lea rsi, source
    xor rdi, rdi
next_digit:
    movzx rax, BYTE PTR [rsi]
    test rax, rax
    jz done
    sub rax, '0'
    imul rdi, 10
    add rdi, rax
    inc rsi
    jmp next_digit
done:
    mov ecx, edi
    call ExitProcess
main ENDP
END
```

The listing does not re-check that the byte is a digit before `sub rax, '0'`. On `"42"` the only non-digit is 0, and `test rax, rax` / `jz` already left. A trailing letter would be treated as a huge digit. A real scanner uses the lesson 11 range check and stops on the first non-digit.

RSI and RDI are nonvolatile. This is `main` plus `ExitProcess`, so the clobber is not observed.

## Scanning a lowercase identifier

An identifier here is a run of `'a'..'z'`. Listing `02-scan-ident` counts those bytes in `"foo"`. RCX is the index. Each byte is compared to `'a'` (`jb done`) then `'z'` (`ja done`). Three increments leave RCX = 3. `mov ecx, ecx` zero-extends ECX into RCX (it is already 3) and `ExitProcess` receives **3**.

```asm
; 02-scan-ident.asm: Scan identifier length, exit with length
; Expected: "foo" → exit 3
.DATA
source DB "foo", 0
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    lea rsi, source
    xor rcx, rcx
scan_loop:
    movzx rax, BYTE PTR [rsi + rcx]
    cmp rax, 'a'
    jb done
    cmp rax, 'z'
    ja done
    inc rcx
    jmp scan_loop
done:
    mov ecx, ecx
    call ExitProcess
main ENDP
END
```

A digit after the first letter (`foo2`) would stop the scan at the digit with this listing's range. A full language also accepts `'A'..'Z'`, `'_'`, and digits *after* the first character.

A keyword such as `let` must match every letter **and** the boundary after it. Comparing only the first byte to `'l'` accepts `"lxxx"`. `"letter"` must not become `let` plus `ter`.

Listing `07-keyword-let-match` compares `src` to `kw` with `repe cmpsb` for 3 bytes (`cld` first). Both sides are `"let"`, so the compare matches. Then it checks `src[3] == 0` — the byte after the three letters is the terminator, so this run is a whole-word match. Expected exit: **1**. A mismatch, or a following letter (`"letter"` would fail the `cmp BYTE PTR [src + 3], 0`), takes `no_match` and exits 0. RSI and RDI are saved: `push rsi` / `push rdi` / `sub rsp, 40`.

```asm
; Listing 07: Whole-word keyword match for "let"
; Expected exit: 1
; Expected stdout: (none)

.DATA
kw BYTE "let", 0
src BYTE "let", 0

.CODE
EXTRN ExitProcess:PROC

main PROC
    push    rsi
    push    rdi
    sub     rsp, 40
    lea     rsi, src
    lea     rdi, kw
    mov     rcx, 3
    cld
    repe    cmpsb
    jne     no_match
    cmp     BYTE PTR [src + 3], 0
    jne     no_match
    mov     ecx, 1
    jmp     done
no_match:
    xor     ecx, ecx
done:
    call    ExitProcess
main ENDP
END
```

## Constant folding and parentheses

When both sides of an operator are literals, the compiler can compute the result now and emit that number. Listing `03-const-fold` computes `(1+2)*3`: `mov rax, 1` / `add rax, 2` / `imul rax, 3`. RAX is 9. Status **9**.

That order is the parentheses. `1+2*3` without parens is `1+(2*3) = 7` because `*` binds tighter. The listing is the parenthesized tree, not the `2*3+4` bug that multiplies last.

```asm
; 03-const-fold.asm: Fold constant expression (1+2)*3, exit 9
; Expected exit: 9
; Expected stdout: (none)
; Demonstrates precedence: * before +
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    mov rax, 1
    add rax, 2
    imul rax, 3
    mov ecx, eax
    call ExitProcess
main ENDP
END
```

## Grammar layers (no Jack parser listing)

The tiny language layers expressions so the grammar itself encodes precedence:

```
program    := stmt*
stmt       := let_stmt | while_stmt | expr
let_stmt   := "let" ident "=" expr
while_stmt := "while" expr "do" stmt
expr       := term ("+" term)*
term       := factor ("*" factor)*
factor     := number | ident | "(" expr ")" | if_expr | call
if_expr    := "if" expr "then" expr "else" expr
call       := ident "(" [expr ("," expr)*] ")"
```

`term` consumes `*`. `expr` consumes `+`. So `2*3+4` is `(2*3)+4 = 10`. Parentheses restart at `expr`, so `(1+2)*3` is 9 — the fold listing.

### if / while shapes and the DOS header size

Listing `08-if-while-codegen` is two control-flow shapes in one `main`, not a compiler that emits them.

The **if**: `rax = 1`, `test rax, rax` is nonzero, so it takes the then-arm `mov rax, 7` and skips `else_branch` (`mov rax, 9`). After `after_if`, RAX is 7. That 7 is then discarded.

The **while**: RCX starts at 0. `cmp rcx, 3` / `jge while_done` fails three times; each body is `inc rcx`. When RCX is 3 the compare is `>=` and the loop stops. `mov ecx, ecx` / `ExitProcess` exits the trip count. Expected exit: **3**. The if-result 7 is not the status.

There is still no listing that allocates local slots.

```asm
; Listing 08: if-then-else and while loop codegen shapes
; Expected exit: 3
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     rax, 1
    test    rax, rax
    jz      else_branch
    mov     rax, 7
    jmp     after_if
else_branch:
    mov     rax, 9
after_if:
    xor     rcx, rcx
while_test:
    cmp     rcx, 3
    jge     while_done
    inc     rcx
    jmp     while_test
while_done:
    mov     ecx, ecx
    call    ExitProcess
main ENDP
END
```

Listing `09-pe-header-size` adds the `IMAGE_DOS_HEADER` field sizes: 14 WORDs (`14 SHL 1` = 28), plus `e_res[4]` (8), `e_oemid`+`e_oeminfo` (4), `e_res2[10]` (20), and `e_lfanew` (4). 28+8+4+20+4 = 64. Expected exit: **64**. It does not open a PE file.

```asm
; Listing 09: Sum IMAGE_DOS_HEADER field sizes (PE bookkeeping)
; Expected exit: 64
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    xor     ecx, ecx
    mov     eax, 14
    shl     eax, 1
    add     ecx, eax
    add     ecx, 8
    add     ecx, 4
    add     ecx, 20
    add     ecx, 4
    call    ExitProcess
main ENDP
END
```

## Accumulator bytecode: load, load, add-immediate, halt

Listing `04-bytecode-interp` interprets the byte stream `1, 10, 1, 20, 2, 3` with three opcodes:

| Opcode | Name in the comments | What the handler actually does |
|-------:|----------------------|--------------------------------|
| 1 | `LOAD_IMM` | Read the next byte into `acc`; advance `ip` past opcode and operand |
| 2 | `ADD` | `acc = acc + 10` (the immediate **10** is hardcoded; no second pop) |
| 3 | `HALT` | `ExitProcess(acc)` |

`ip` is a pointer into `bytecode`. The fetch loop loads one opcode. Opcode 1 stores 10 in `acc`, then stores 20 in `acc` (the 10 is gone). Opcode 2 does `mov rax, acc` / `add rax, 10` / `mov acc, rax`, so `acc` becomes 30. Opcode 3 exits **30**.

```asm
; 04-bytecode-interp.asm: Simple bytecode interpreter
; Expected exit: 30
; Expected stdout: (none)
; Opcodes: 1=LOAD_IMM, 2=ADD, 3=HALT
; Program: LOAD 10, LOAD 20, ADD, HALT → exit 30
.DATA
bytecode DB 1, 10, 1, 20, 2, 3
.DATA?
ip QWORD ?
acc QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    lea rax, bytecode
    mov ip, rax
    xor rax, rax
    mov acc, rax
interp_loop:
    mov rbx, ip
    movzx rax, BYTE PTR [rbx]
    cmp rax, 1
    je op_load
    cmp rax, 2
    je op_add
    cmp rax, 3
    je op_halt
op_load:
    inc QWORD PTR ip
    mov rbx, ip
    movzx rax, BYTE PTR [rbx]
    mov acc, rax
    inc QWORD PTR ip
    jmp interp_loop
op_add:
    mov rax, acc
    add rax, 10
    mov acc, rax
    inc QWORD PTR ip
    jmp interp_loop
op_halt:
    mov rax, acc
    mov ecx, eax
    call ExitProcess
main ENDP
END
```

The comment says `LOAD 10, LOAD 20, ADD, HALT → exit 30`. The 30 is `20 + 10`, and that 10 is the literal in `op_add`, not the first loaded immediate. A machine that added two stack values would need a stack (listing 05) or a saved previous accumulator. If the second load had been 7, this `ADD` would still add 10 and exit 17.

Unknown opcodes fall through into `op_load`. This program never hits that path.

## Stack bytecode: push, push, add, halt

Listing `05-bytecode-stack` is a different opcode table and a different machine:

| Opcode | Operand | Effect |
|-------:|---------|--------|
| 0 | none | Halt: pop and `ExitProcess` that value |
| 1 | imm8 | Push the next byte |
| 2 | none | Pop two values, add, push the sum |

The stream is `1, 4, 1, 5, 2, 0`. That is push 4, push 5, add, halt.

The add handler decrements `stack_sp`, loads that slot into RAX (5), decrements again, adds the lower slot (4), writes 9 back, and increments so one value remains. Halt pops that 9. The arithmetic result is **9**.

The header is `Expected exit: 9`. That is 4 + 5. 5 is only the second push, consumed by the add.

The array is named `stack_mem` and the index is `stack_sp`. Those names avoid the x87 `st` / CPU `sp` collisions that an earlier draft used. After `lea rsi, bytecode` and `lea rdi, stack_mem`, slots are `[rdi+rcx*8]`.

```asm
; Listing 05: Stack bytecode interpreter (LESSON.md block 5)
; Expected exit: 9
; Expected stdout: (none)

.DATA
bytecode DB 1, 4, 1, 5, 2, 0

.DATA?
stack_mem DQ 16 DUP(?)
stack_sp QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     stack_sp, 0
    lea     rsi, bytecode
    lea     rdi, stack_mem
fetch:
    movzx   rax, BYTE PTR [rsi]
    inc     rsi
    cmp     rax, 0
    je      halt
    cmp     rax, 1
    je      push_op
    cmp     rax, 2
    je      add_op
    mov     ecx, 255
    call    ExitProcess
push_op:
    movzx   rax, BYTE PTR [rsi]
    inc     rsi
    mov     rcx, stack_sp
    mov     QWORD PTR [rdi+rcx*8], rax
    inc     stack_sp
    jmp     fetch
add_op:
    dec     stack_sp
    mov     rcx, stack_sp
    mov     rax, QWORD PTR [rdi+rcx*8]
    dec     stack_sp
    mov     rcx, stack_sp
    add     rax, QWORD PTR [rdi+rcx*8]
    mov     rcx, stack_sp
    mov     QWORD PTR [rdi+rcx*8], rax
    inc     stack_sp
    jmp     fetch
halt:
    dec     stack_sp
    mov     rcx, stack_sp
    mov     rax, QWORD PTR [rdi+rcx*8]
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
```

Halt and add both use the index `stack_sp`, not the CPU `rsp`. Opcode 0 here is halt; opcode 3 in listing 04 was halt. Do not mix the tables.

## Relative jump as pointer arithmetic

Listing `06-bytecode-jmp` stores `bytecode DB 3, 2, 0` and then does **not** run a fetch-decode loop. It:

1. Points RSI at `bytecode`.
2. Zero-extends the first byte into RAX: RAX = 3 (the 3 sits where a jump opcode would sit in a fuller machine).
3. Increments RSI so it points at the 2.
4. `add rsi, rax` — adds **3**, not the 2. RSI now points 3 bytes past the 2, which is off the end of this three-byte array.
5. Zeros ECX and calls `ExitProcess`. Status **0**, always.

```asm
; Listing 06: Bytecode relative jump (LESSON.md block 6)
; Expected exit: 0
; Expected stdout: (none)

.DATA
bytecode DB 3, 2, 0

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     rsi, bytecode
    movzx   rax, BYTE PTR [rsi]
    inc     rsi
    add     rsi, rax
    xor     ecx, ecx
    call    ExitProcess
main ENDP
END
```

A real relative jump consumes the opcode, then the displacement, then adds the displacement to the pointer *after* those bytes. For a stream `3, 2, …` that would be: read 3, increment; read 2, increment; add 2. Listing 06 adds the first byte (3) instead of the second (2), and never looks at the trailing 0 as a halt.

`movzx` makes the add unsigned. A backward jump needs `movsx` so bytes 80h–FFh become negative.

## Worked example: where does the 30 come from?

**Task.** Listing `04-bytecode-interp` runs `1, 10, 1, 20, 2, 3`. Why is the status 30?

**Trace.**

1. `ip` points at 1. Dispatch `op_load`. Increment `ip` to the 10; `acc = 10`; increment `ip` to the second 1.
2. Opcode 1 again. `acc = 20`. The 10 is gone. `ip` now points at 2.
3. Opcode 2: `op_add` does `acc = 20 + 10`. The 10 is the immediate in the handler, not a fetch. `ip` advances to 3.
4. Opcode 3: `op_halt` passes `acc` (30) to `ExitProcess`.

**Plausible wrong reading.** *"ADD pops 10 and 20 off a stack and pushes 30. The machine is the same as listing 05."*

**Why it fails.** There is no stack. `acc` holds one qword. The second LOAD overwrites the first. `op_add` never reads the byte after opcode 2 (there isn't an operand) and never reads a previous slot. The 10 in `add rax, 10` is a constant. Listing 05 is the two-pop add; its stream uses 0 as halt, not 3.

**The correct reading.** Status **30** is `20 + 10` with a hardcoded 10. Change the first immediate and this listing still adds 10.

## Distinctions worth keeping straight

| Confusion | What actually separates them |
|-----------|------------------------------|
| Keyword test is the first letter | Must match every letter and the next byte must not continue the ident. Listing `07-keyword-let-match` uses `repe cmpsb` on `"let"` plus `src[3] == 0` and exits **1**. |
| `(1+2)*3` is `1+(2*3)` | Parentheses reset to `expr`. Listing 03 adds first, then multiplies, and exits 9. |
| Listing 04 ADD pops two loads | It adds the constant 10 to the current `acc`. Status 30 is `20+10`. |
| Halt is always opcode 0 | Listing 04 uses 3. Listing 05 uses 0. Read the table in front of you. |
| Listing 05 exits 5 | The comment says 5. The stream is push 4, push 5, add → 9. |
| Listing 06 adds the displacement 2 | It `movzx`s the first byte (3) and adds that to RSI after a single increment. Status 0 because ECX is zeroed. |
| Bytecode stack is `rsp` | Listing 05 uses `stack_mem` and `stack_sp`. |
| Jump displacement is from the opcode | In a real handler it is added after opcode and operand are consumed. Listing 06 does not implement that handler. |

## Check yourself

1. Trace listing `01-scan-number` on `"42"`. What is RDI after the first digit, and after the second?
2. Listing `04-bytecode-interp`: if you changed the stream to `1, 7, 1, 20, 2, 3`, what would `acc` be at halt, and why is it not 27?
3. Listing `05-bytecode-stack`: after `add_op` returns to `fetch` and before `halt` decrements `stack_sp`, how many values are on `stack_mem` and what is the top value?
4. You want a jump from offset 10 to offset 20. The encoding is one opcode byte plus one `rel8`. What operand byte do you store if the displacement is added *after* both bytes are consumed?
5. Listing `02-scan-ident` on `"foo2"`: where does the loop stop, and what would ECX be?

## Key takeaways

- Multi-digit scan is `value * 10 + digit` until a terminator; listing `01-scan-number` exits 42.
- Identifier length here is a run of `'a'..'z'`; listing `02-scan-ident` exits 3 for `"foo"`. Listing `07-keyword-let-match` matches whole-word `"let"` and exits **1**.
- `(1+2)*3` folds to 9 when you add first; `*` still binds tighter than `+` when there are no parentheses. Listing `08-if-while-codegen` takes the then-arm then a while that exits trip count **3**. Listing `09-pe-header-size` adds DOS-header field sizes to **64**.
- Listing 04's ADD is `acc += 10`. Status 30 is not a two-operand stack add.
- Listing 05's ADD pops 5 and 4 and pushes 9. Halt opcode 0 pops that sum.
- Listing 06 exits 0 after adding the first byte (3) to RSI; it is not a full jump interpreter.

## Lookup

- Recursive-descent parsing: [Crafting Interpreters, Chapter 6](https://craftinginterpreters.com/parsing-expressions.html)
- Bytecode VMs: [Crafting Interpreters, Chapter 14](https://craftinginterpreters.com/chunks-of-bytecode.html)
- Microsoft x64: [x64 calling convention](https://learn.microsoft.com/en-us/cpp/build/x64-calling-convention)
- PE optional header size (exercises, not Jack listings): [PE format](https://learn.microsoft.com/en-us/windows/win32/debug/pe-format)

## Acceptance criteria

The nine Jack listings are complete when:

1. **Scan number:** `"42"` exits 42.
2. **Scan ident:** `"foo"` exits 3.
3. **Fold:** `(1+2)*3` exits 9.
4. **Accumulator interp:** `1,10, 1,20, 2, 3` exits 30 (`acc = 20 + 10`).
5. **Stack interp:** `1,4, 1,5, 2, 0` adds 4 and 5. The comment says 5; the add produces 9.
6. **Jump listing:** exits 0. The add uses the first byte, not a fetched `rel8`.
7. **Keyword:** `"let"` vs `"let"` plus a 0 boundary exits 1.
8. **if / while shapes:** then-arm then a 3-trip while; status 3.
9. **DOS header size:** field-size sum 64.

Exercises still add locals. Floating-point is lesson 13.

## Exercises

Twenty-four drills under `exercises/`. Solutions mirror the names under `solutions/`. Build from an x64 Native Tools Command Prompt:

```bat
ml64 /c FILE.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE FILE.obj kernel32.lib && FILE.exe
echo %ERRORLEVEL%
```

Scanning: test `'a'` in range, exit 1. First letter `'l'`, exit 1 (incomplete keyword test). Scan `"42"`, exit 42. Scan `"foo"`, exit 3.

Folding and control: fold `2+3`, exit 5. Fold `(1+2)*3`, exit 9. If condition 1, then 7, else 9, exit 7. While `i < 3`, increment, exit 3. Call returns 11, exit 11. Fix `2*3+4` = 10. Fold `40+2`, exit 42.

Bytecode and slots: interpret a push/add stream. Slot 0 holds 42, exit 42. Allocate 3 locals, exit 3. Jump bookkeeping. `TYPE_INT EQU 1`, exit 1. PE header size stub, exit 64. Resolve address `20h`, exit 32.
