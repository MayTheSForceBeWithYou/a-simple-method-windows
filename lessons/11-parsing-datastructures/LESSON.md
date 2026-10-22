# Lesson 11 — Parsing and Data Structures

Lesson 10 gave you a byte buffer and a cursor. This lesson turns those bytes into structures you can walk: a token kind, a linked-list node, a bump cursor, an explicit stack or queue, and a three-field AST node. None of that is a library type. It is pointer arithmetic, a null check before a load, and an integer index into a qword array.

Every listing here is a complete MASM program: `.CODE`, `EXTRN ExitProcess:PROC`, `main PROC` / `main ENDP`, and `END`. The process status is the first argument to `ExitProcess`, in RCX (the listings usually write ECX). Assemble and link from an x64 Native Tools prompt:

```bat
ml64 /c FILE.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE FILE.obj kernel32.lib && FILE.exe
echo %ERRORLEVEL%
```

These entry points call `ExitProcess` without a `sub rsp, 32` shadow space and without `PROC FRAME` unwind codes. `ExitProcess` does not return, so the process still dies. A procedure that *returns* after other `call`s must honor the Microsoft x64 contract from lessons 00 and 04.

## What this lesson asks of you

Classify a byte as a digit with two unsigned compares. Assert the next input character with `expect`. Lay out a list node as value then `next`, walk it only after `test` proves the pointer is not 0, and push-front by writing `new.next = old_head` then `head = new`. Allocate from a bump arena by adding the request size to a cursor. Push and pop an explicit stack (array plus index), and enqueue/dequeue a FIFO queue the same way — those indices are not `rsp`. Mix an integer hash and store a slot by byte offset. Represent an AST node as three qwords and sum the fields.

## Why these structures matter

Lesson 12's tiny compiler scans digits and identifiers, folds constants, and interprets a bytecode stream. The scan is the digit test from listing `01-token-classify` plus the accumulation in lesson 12. AST nodes are the three qwords in listing `16-ast-node-fields`, typically allocated from the bump cursor in listings `03-arena-alloc` and `09-arena-bump-alloc`. An evaluator uses the explicit stack in listings `04-stack-push-pop` and `13-stack-push-pop`. Lesson 17's BFS pathfinder uses the FIFO queue in listings `14-queue-fifo` and `17-queue-ops-sequence`, and the wrap mask in listings `15-ring-tail-wrap` and `18-ring-tail-mask`. You build each piece here as a process that exits a single observable integer.

## Classifying a byte as a digit

A lexer (tokenizer) scans source text and emits tokens. Each token has a **kind** (number, identifier, operator, keyword, end of input) and a **lexeme** (the source slice it was cut from, plus a length). Kinds are ordinary integers. A common encoding is `TK_EOF = 0`, `TK_NUM = 1`, `TK_IDENT = 2`.

A byte is a decimal digit when it sits in the inclusive range `'0'` (48) through `'9'` (57). Listing `01-token-classify` loads `'7'` into AL and does two unsigned compares: below `'0'` is not a digit; above `'9'` is not a digit. `'7'` passes both, so ECX becomes 1 and `ExitProcess` ends the process with status **1**. A non-digit would take `not_digit`, zero ECX, and exit 0.

```asm
; 01-token-classify.asm: Classify byte as digit, exit 1 if digit else 0
; Expected exit: 1
; Expected stdout: (none)
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    mov al, '7'
    cmp al, '0'
    jb not_digit
    cmp al, '9'
    ja not_digit
    mov ecx, 1
    jmp done
not_digit:
    xor ecx, ecx
done:
    call ExitProcess
main ENDP
END
```

The compares are unsigned (`jb` / `ja`). That is correct for ASCII bytes. Do not use `jl` / `jg` here: those are signed, and a byte with the high bit set would compare as negative.

## Expect: asserting the next character

Recursive-descent parsers expose a helper `expect(char)`: compare the byte at the cursor to the wanted character, advance on a match, and take an error path on a mismatch. Listing `05-expect-char` does that on the first byte of `"(1)"`. RSI holds the address of `input`. AL holds `'('`. `cmp BYTE PTR [rsi], al` matches, so the listing increments RSI (now pointing at `'1'`) and exits **1**. A mismatch would zero ECX and exit 0.

```asm
; Listing 05: Parser expect helper (LESSON.md block 5)
; Expected exit: 1
; Expected stdout: (none)

.DATA
input DB "(1)", 0

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     rsi, input
    mov     al, '('
    cmp     BYTE PTR [rsi], al
    jne     error
    inc     rsi
    mov     ecx, 1
    jmp     done
error:
    xor     ecx, ecx
done:
    call    ExitProcess
main ENDP
END
```

RSI is **nonvolatile** on Windows. This listing is `main` and then `ExitProcess`, so the clobber is not observed. A returning `expect` that writes RSI must save and restore it.

Skipping spaces is the same cursor walk: while the byte is 32, increment. Listing `19-skip-whitespace` starts at `"  7"` (two spaces, then `'7'`). The loop loads `[rsi]`, compares to 32, and increments twice. `at_digit` then has AL = `'7'` (55). `sub ecx, '0'` yields 7. Expected exit: **7**. RSI is saved: `push rsi` / `sub rsp, 32` (one push plus 32).

```asm
; Listing 19: Skip ASCII spaces, parse digit (LESSON.md)
; Expected exit: 7
; Expected stdout: (none)

.DATA
src BYTE "  ", "7", 0

.CODE
EXTRN ExitProcess:PROC

main PROC
    push    rsi
    sub     rsp, 32
    lea     rsi, src
skip:
    movzx   eax, BYTE PTR [rsi]
    cmp     al, 32
    jne     at_digit
    inc     rsi
    jmp     skip

at_digit:
    movzx   ecx, al
    sub     ecx, '0'
    call    ExitProcess
main ENDP
END
```

Copying a lexeme is a counted or NUL-terminated store plus a length that does **not** include a terminator you happened to write. Listing `20-copy-lexeme` copies `"let"` into `dst` until the 0, stores the count in `lex_len`, and exits that DWORD. Three bytes copied; the 0 is the stop test, not a stored payload. Expected exit: **3**. RSI and RDI are saved: `push rsi` / `push rdi` / `sub rsp, 40`.

```asm
; Listing 20: Copy lexeme bytes and exit length (LESSON.md)
; Expected exit: 3
; Expected stdout: (none)

.DATA
src BYTE "let", 0

.DATA?
dst BYTE 8 DUP(?)
lex_len QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    push    rsi
    push    rdi
    sub     rsp, 40
    lea     rsi, src
    lea     rdi, dst
    xor     rcx, rcx
copy:
    movzx   eax, BYTE PTR [rsi + rcx]
    test    al, al
    jz      done_copy
    mov     BYTE PTR [rdi + rcx], al
    inc     rcx
    jmp     copy

done_copy:
    mov     lex_len, rcx
    mov     ecx, DWORD PTR lex_len
    call    ExitProcess
main ENDP
END
```

## Linked-list node layout

A **linked list** is a chain of nodes. Each node holds a value and a pointer to the next node. The end of the list is the integer 0 (a null pointer), not a sentinel node you allocated to mean "end."

Listing `06-list-node-layout` stores that layout as two adjacent qwords in `.DATA?`: `node_value` then `node_next`. It writes 9 and 0, then passes 9 to `ExitProcess` without reading the fields back. The observable status is **9**. The point is the memory shape: value at offset 0, next at offset 8.

```asm
; Listing 06: Singly-linked node layout (LESSON.md block 6)
; Expected exit: 9
; Expected stdout: (none)

.DATA?
node_value QWORD ?
node_next QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     node_value, 9
    mov     node_next, 0
    mov     ecx, 9
    call    ExitProcess
main ENDP
END
```

## Walking a list: test the pointer before you load it

Listing `02-linked-list-walk` builds three initialized nodes in `.DATA`:

| Label | Value (offset 0) | Next (offset 8) |
|-------|-----------------:|-----------------|
| `node1` | 10 | `offset node2` |
| `node2` | 20 | `offset node3` |
| `node3` | 30 | 0 |

`offset node2` is the address of `node2`, not the integer 2. The walk loads that address into RAX, then follows `[rax+8]` for `next`.

The loop does **`test rax, rax` before any load through RAX**. Zero means the walk is done. A live pointer means "this is a node": increment the count in ECX, then load the next pointer. The values 10, 20, 30 are never added. Three successful tests yield ECX = 3. Status **3**.

```asm
; 02-linked-list-walk.asm: Walk linked list, count nodes, exit count
; Expected exit: 3
; Expected stdout: (none)
.DATA
node1 QWORD 10, offset node2
node2 QWORD 20, offset node3
node3 QWORD 30, 0
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    lea rax, node1
    xor ecx, ecx
walk_loop:
    test rax, rax
    jz done
    inc ecx
    mov rax, [rax+8]
    jmp walk_loop
done:
    call ExitProcess
main ENDP
END
```

An empty list is `head = 0`. The first `test` jumps to `done` with ECX still 0. If you load `[rax]` or `[rax+8]` *before* the test, a null head is a fault.

## Push-front

To cons a node onto the front of a list:

1. Write the new node's value.
2. Write `new.next = old_head`.
3. Write `head = new`.

Listing `07-ll-push-front` does that twice, first with value 1 (`node1`) then value 2 (`node2`). `head` lives in `.DATA?`, so the loader zeros it. The first `mov rax, head` therefore reads 0, and `node1`'s next becomes 0. After the second push, `head` points at `node2`, `node2.next` points at `node1`, and `[head]` is 2. Status **2**.

```asm
; Listing 07: Push front onto intrusive list (LESSON.md block 7)
; Expected exit: 2
; Expected stdout: (none)

.DATA?
head QWORD ?
node1 DQ 2 DUP(?)
node2 DQ 2 DUP(?)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     QWORD PTR node1, 1
    mov     QWORD PTR node1[8], 0
    mov     rax, head
    mov     QWORD PTR node1[8], rax
    lea     rax, node1
    mov     head, rax

    mov     QWORD PTR node2, 2
    mov     rax, head
    mov     QWORD PTR node2[8], rax
    lea     rax, node2
    mov     head, rax

    mov     rsi, head
    mov     rax, [rsi]
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
```

The first store to `node1[8]` writes 0, then the next instruction overwrites it with `head` (also 0). The second write is the one the algorithm needs; the first is redundant.

## Walking and summing

Listing `08-ll-sum` is the same null-before-load walk, but it adds `[rsi]` (the value) before following `[rsi+8]`. The chain is `n1=3 → n2=4 → n3=5 → 0`. RDI accumulates 3 + 4 + 5 = 12. Status **12**.

MASM initializes `n2 DQ 4, n3` with the address of `n3` in the second qword — the same idea as `offset node2` in listing 02.

```asm
; Listing 08: Walk linked list and sum values (LESSON.md block 8)
; Expected exit: 12
; Expected stdout: (none)

.DATA
n3 DQ 5, 0
n2 DQ 4, n3
n1 DQ 3, n2

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     rsi, n1
    xor     rdi, rdi
walk:
    test    rsi, rsi
    jz      done
    add     rdi, [rsi]
    mov     rsi, [rsi+8]
    jmp     walk
done:
    mov     ecx, edi
    call    ExitProcess
main ENDP
END
```

Listing 02 exits a count. Listing 08 exits a sum. Both die if you dereference before `test`.

## Arena: one bump

An **arena** is a contiguous block plus a **bump cursor**. Allocate N bytes by returning the current cursor and adding N to it. There is no `free` and no hole list. Reset means set the cursor back to the base (or to 0 if you store an offset).

Listing `03-arena-alloc` keeps an absolute pointer in `arena_cursor`. It sets that pointer to `lea rax, arena`, copies it to RBX, adds 16, writes the new cursor, then `sub rbx, rax` so RBX is the **offset from the base**. ECX gets that 16. Status **16**.

```asm
; 03-arena-alloc.asm: Bump allocator, allocate 16 bytes, exit offset
; Expected exit: 16
; Expected stdout: (none)
.DATA?
arena DB 1024 DUP(?)
arena_cursor QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    lea rax, arena
    mov arena_cursor, rax
    mov rbx, arena_cursor
    add rbx, 16
    mov arena_cursor, rbx
    sub rbx, rax
    mov ecx, ebx
    call ExitProcess
main ENDP
END
```

The allocation is the side effect on `arena_cursor`. The exit is not a pointer; it is the number of bytes the cursor moved.

## Arena: two bumps, offset cursor

Listing `09-arena-bump-alloc` stores the cursor as an **offset** starting at 0, not as an absolute address. It adds 16, then adds 16 again. `DWORD PTR bump` is 32. Status **32**.

It never forms `arena + bump`. A caller that wants a pointer would do `lea rax, arena` / `add rax, bump` *before* the add, or save the old offset and add it to the base.

```asm
; Listing 09: Bump-pointer arena allocator (LESSON.md block 9)
; Expected exit: 32
; Expected stdout: (none)

.DATA?
arena DB 4096 DUP(?)
bump QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     bump, 0
    mov     rdi, 16
    mov     rax, bump
    add     bump, rdi
    mov     rdi, 16
    add     bump, rdi
    mov     ecx, DWORD PTR bump
    call    ExitProcess
main ENDP
END
```

Pointers to qwords should be 8-byte aligned. The usual round-up is `aligned = (bump + 7) AND (NOT 7)`. Already-aligned 8 stays 8: `(8 + 7) AND (NOT 7) = 8`. Starting at 1 becomes 8.

Listing `21-arena-align-bump` starts `bump` at 1, adds 7 (8), then `and rax, NOT 7` (clears the low three bits). The result is 8. Expected exit: **8**. Listing 09 never aligns; both of its requests are already multiples of 8 from offset 0.

```asm
; Listing 21: Round bump pointer up to 8-byte alignment
; Expected exit: 8
; Expected stdout: (none)

.DATA?
bump QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     bump, 1
    mov     rax, bump
    add     rax, 7
    and     rax, NOT 7
    mov     bump, rax
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
```

## Vector: fixed-capacity push

A **vector** is a buffer, a length (used slots), and a capacity (allocated slots). Listing `10-vector-push` sets `vec_cap = 8`, `vec_len = 0`, then `lea r10, vec_data` and pushes 10, 20, 30. Each push compares length to capacity, stores at `[r10+rcx*8]`, and increments length. After three pushes, `DWORD PTR vec_len` is 3. Status **3**. There is no reallocation. A fourth push past a full buffer would jump to `done` and still exit the current length.

```asm
; Listing 10: Fixed-capacity vector push (LESSON.md block 10)
; Expected exit: 3
; Expected stdout: (none)

.DATA?
vec_data DQ 8 DUP(?)
vec_len QWORD ?
vec_cap QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     r10, vec_data
    mov     vec_cap, 8
    mov     vec_len, 0
    mov     rdi, 10
    mov     rax, vec_len
    cmp     rax, vec_cap
    jae     done
    mov     rcx, vec_len
    mov     QWORD PTR [r10+rcx*8], rdi
    inc     vec_len
    mov     rdi, 20
    mov     rax, vec_len
    cmp     rax, vec_cap
    jae     done
    mov     rcx, vec_len
    mov     QWORD PTR [r10+rcx*8], rdi
    inc     vec_len
    mov     rdi, 30
    mov     rax, vec_len
    cmp     rax, vec_cap
    jae     done
    mov     rcx, vec_len
    mov     QWORD PTR [r10+rcx*8], rdi
    inc     vec_len
done:
    mov     ecx, DWORD PTR vec_len
    call    ExitProcess
main ENDP
END
```

## Integer hash mix

A hash table maps a key to a slot index by mixing the key, then reducing modulo the table size. Listing `11-hash-mix` mixes the integer 5: copy to RBX, shift RBX left 3 (5 × 8 = 40), XOR into RAX. `5 XOR 40 = 45`. Status **45**. There is no modulo and no table.

```asm
; Listing 11: Integer hash mix (LESSON.md block 11)
; Expected exit: 45
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     rax, 5
    mov     rbx, rax
    shl     rbx, 3
    xor     rax, rbx
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
```

## Direct slot store

Listing `12-hashmap-slot` is a four-qword table and a raw offset. `slots[16]` is eight bytes times index 2. It writes 42 there, reads it back, and exits **42**. No hash, no key compare, no probe. A real table would mix the key, mask or divide by the slot count, and store a key/value pair.

```asm
; Listing 12: Direct-index hash table slot (LESSON.md block 12)
; Expected exit: 42
; Expected stdout: (none)

.DATA?
slots DQ 4 DUP(?)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     QWORD PTR slots[16], 42
    mov     rax, slots[16]
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
```

## Explicit stack: push 42, pop 42

`rsp` and `call`/`ret` are for procedure frames (lesson 04). Your own LIFO is an array plus an index. Listing `04-stack-push-pop` does `lea r10, stack_data`, zeros `stack_top`, writes 42 at `[r10+rbx*8]` with RBX = 0, increments the index, then decrements it and reads the same slot back. Status **42**.

```asm
; 04-stack-push-pop.asm: Explicit stack (array+index), push 42, pop, exit popped value
; Expected exit: 42
; Expected stdout: (none)
.DATA?
stack_data DQ 16 DUP(?)
stack_top QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    lea     r10, stack_data
    mov     stack_top, 0
    mov     rax, 42
    mov     rbx, stack_top
    mov     QWORD PTR [r10+rbx*8], rax
    inc     stack_top
    dec     stack_top
    mov     rbx, stack_top
    mov     rax, QWORD PTR [r10+rbx*8]
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
```

Push stores at the current index, then increments. Pop decrements, then loads. The popped value stays in the array until something overwrites that slot; the index is what makes the slot dead.

## Explicit stack: last in is first out

Listing `13-stack-push-pop` pushes 1, then 2, then pops. The pop reads 2. Status **2**.

The listing names its index `stack_sp` — not `sp`, so it cannot collide with the 16-bit view of RSP. After `lea r10, stk`, push/pop use `[r10+rcx*8]`. The intended meaning is still "integer index in memory, next to `stk`."

```asm
; Listing 13: Array stack push/pop (LESSON.md block 13)
; Expected exit: 2
; Expected stdout: (none)

.DATA?
stk DQ 16 DUP(?)
stack_sp QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     r10, stk
    mov     stack_sp, 0
    mov     rdi, 1
    mov     rcx, stack_sp
    mov     QWORD PTR [r10+rcx*8], rdi
    inc     stack_sp
    mov     rdi, 2
    mov     rcx, stack_sp
    mov     QWORD PTR [r10+rcx*8], rdi
    inc     stack_sp
    dec     stack_sp
    mov     rcx, stack_sp
    mov     rax, QWORD PTR [r10+rcx*8]
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
```

## FIFO queue: enqueue 7, enqueue 8, dequeue

A queue stores at `tail` and loads from `head`. Listing `14-queue-fifo` zeros both indices, writes 7 at slot 0, writes 8 at slot 1, then reads slot 0. Status **7**. First in, first out.

There is no wrap. `inc tail` / `inc head` are monotonic. A fifth enqueue on this four-slot `q` would write `q[4*8]`, past the array.

```asm
; Listing 14: FIFO queue enqueue/dequeue (LESSON.md block 14)
; Expected exit: 7
; Expected stdout: (none)

.DATA?
q DQ 4 DUP(?)
head QWORD ?
tail QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     r10, q
    mov     head, 0
    mov     tail, 0
    mov     rdi, 7
    mov     rcx, tail
    mov     QWORD PTR [r10+rcx*8], rdi
    inc     tail
    mov     rdi, 8
    mov     rcx, tail
    mov     QWORD PTR [r10+rcx*8], rdi
    inc     tail
    mov     rcx, head
    mov     rax, QWORD PTR [r10+rcx*8]
    inc     head
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
```

Listing `17-queue-ops-sequence` is the same sequence with immediate stores instead of RDI. It also exits **7**.

```asm
; Listing 17: Queue enqueue/dequeue sequence (LESSON.md block 17)
; Expected exit: 7
; Expected stdout: (none)

.DATA?
q DQ 4 DUP(?)
head QWORD ?
tail QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     r10, q
    mov     head, 0
    mov     tail, 0
    mov     rcx, tail
    mov     QWORD PTR [r10+rcx*8], 7
    inc     tail
    mov     rcx, tail
    mov     QWORD PTR [r10+rcx*8], 8
    inc     tail
    mov     rcx, head
    mov     rax, QWORD PTR [r10+rcx*8]
    inc     head
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
```

## Ring tail: increment, then mask

A **ring buffer** reuses slots by wrapping the index with a mask. Capacity must be a power of two so `index AND (capacity-1)` equals `index modulo capacity`. Listing `15-ring-tail-wrap` starts `tail` at 3 (last slot of a four-slot ring), increments to 4, then `and tail, 3`. `4 AND 3 = 0`. Status **0**. The next enqueue would land in slot 0.

```asm
; Listing 15: Ring buffer tail wrap mask (LESSON.md block 15)
; Expected exit: 0
; Expected stdout: (none)

.DATA?
tail QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     tail, 3
    inc     tail
    and     tail, 3
    mov     ecx, DWORD PTR tail
    call    ExitProcess
main ENDP
END
```

Listing `18-ring-tail-mask` shows the mask alone, without an increment: `tail = 7`, then `and tail, 3`. `7 AND 3 = 3`. `DWORD PTR tail` is 3, so `ExitProcess` receives **3**. The header is `Expected exit: 3`. 0 would be `8 AND 3`, or the increment-then-mask of listing 15 starting at 3.

```asm
; Listing 18: Tail index wrap with mask (LESSON.md block 18)
; Expected exit: 3
; Expected stdout: (none)

.DATA?
tail QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     tail, 7
    and     tail, 3
    mov     ecx, DWORD PTR tail
    call    ExitProcess
main ENDP
END
```

`head == tail` is both empty and full unless you also store a count, or you keep one slot empty on purpose. These two listings only wrap an index.

## AST node fields

An **abstract syntax tree** node is three qwords: a kind, a left child (or a literal value), and a right child. Listing `16-ast-node-fields` writes `kind=1`, `left=2`, `right=3`, adds them, and exits **6**. The numbers are field contents, not a parsed `1+2+3` expression. Lesson 12 walks values like these; it does not build this node.

```asm
; Listing 16: AST node field layout (LESSON.md block 16)
; Expected exit: 6
; Expected stdout: (none)

.DATA?
node_kind QWORD ?
node_left QWORD ?
node_right QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     node_kind, 1
    mov     node_left, 2
    mov     node_right, 3
    mov     rax, node_kind
    add     rax, node_left
    add     rax, node_right
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
```

`*` binds tighter than `+`, so `2 + 3 * 4` is `2 + (3 * 4) = 14`, not `(2 + 3) * 4 = 20`. Represent binding powers as integers (`+` = 10, `*` = 20) when you write a Pratt parser.

Listing `22-pratt-binding-power` defines `BP_ADD EQU 10` and `BP_MUL EQU 20`. It compares them: 20 is not `<=` 10, so it evaluates `3 * 4 + 2` as `imul` then `add` and exits EAX. Expected exit: **14**. The `wrong_order` path (if `*` were not tighter) would exit **20**. The grammar layering in lesson 12 encodes the same fact.

```asm
; Listing 22: Pratt binding powers: * binds tighter than +
; Expected exit: 14
; Expected stdout: (none)
;
; BP_MUL > BP_ADD, so 2 + 3 * 4 is evaluated as 2 + (3 * 4).

BP_ADD EQU 10
BP_MUL EQU 20

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     eax, BP_MUL
    cmp     eax, BP_ADD
    jle     wrong_order
    mov     rax, 3
    imul    rax, 4
    add     rax, 2
    mov     ecx, eax
    call    ExitProcess
wrong_order:
    mov     ecx, 20
    call    ExitProcess
main ENDP
END
```

## Worked example: count, sum, or last value?

**Task.** Listing `02-linked-list-walk` visits nodes whose values are 10, 20, and 30. What does `ExitProcess` receive?

**What the loop writes.** ECX starts at 0. Each live node does `inc ecx` and `mov rax, [rax+8]`. Nobody adds `[rax]`. After three nodes RAX becomes 0, `test` jumps to `done`, and ECX is 3.

**Plausible wrong reading.** *"A walk accumulates the payload, so the status is 10+20+30 = 60. Or it exits the last value, 30."*

**Why it fails.** Listing 02 never loads offset 0. Listing `08-ll-sum` is the walk that adds values, and those values are 3, 4, 5 — status 12, not 60. "Walk" names the pointer motion. What you exit is whatever you put in ECX: a count, a sum, or a field you chose.

**The correct reading.** Status **3**. The payloads are decorations so you can see three distinct nodes in the listing.

## Distinctions worth keeping straight

| Confusion | What actually separates them |
|-----------|------------------------------|
| Null is a sentinel node | Null is the integer 0. A sentinel would be an allocated node you treat as "end." Listings 02 and 08 stop on 0. |
| Listing 02 exits 60 or 30 | It increments a count. Status 3. Listing 08 exits the sum 12. |
| Test the pointer after you load through it | `test` / `jz` belongs *before* `[rax]` or `[rsi]`. A null head faults if you load first. |
| Listing 03 and listing 09 store the same cursor | 03 stores an absolute pointer and exits the offset 16. 09 stores an integer offset and exits 32 after two adds. |
| Alignment is `bump AND 7` | That is the misalignment remainder. Round-up is `(bump + 7) AND (NOT 7)`. Listing `21-arena-align-bump` starts at 1 and exits **8**. |
| `rsp` is your expression stack | `rsp` is the CPU stack. Listings 04 and 13 use an array plus an index. Listing 13's name `sp` collides with the 16-bit stack pointer. |
| Listings 14 and 17 wrap the ring | They only increment. Wrap is listings 15 (inc then mask → 0) and 18 (mask 7 → 3). |
| Lexeme length includes a terminator | Length is payload bytes. A stored 0 does not count. |
| Windows `expect` takes the char in AL and the pointer in RSI as a documented ABI | That is this listing's private convention. Win32 arguments are RCX, RDX, R8, R9. RSI is callee-saved. |

## Check yourself

1. Listing `01-token-classify` compares AL to `'0'` then `'9'`. What status do you get for AL = `'/'` (ASCII 47), and which label runs?
2. In listing `02-linked-list-walk`, why is `test rax, rax` above `inc ecx` and `mov rax, [rax+8]`, not below them? What status does an empty list (RAX = 0 on entry) produce?
3. Listing `09-arena-bump-alloc` never touches `arena`. What integer is in `bump` at `ExitProcess`, and what would you add to `lea rax, arena` to get the next free byte?
4. Listings `14-queue-fifo` and `13-stack-push-pop` both store a first value then a second. Which index does each read on the way out, and why is one status 7 and the other 2?
5. Listing `15-ring-tail-wrap` starts at 3 and exits 0. Listing `18-ring-tail-mask` starts at 7. What is `7 AND 3`, and why is that not 0?

## Key takeaways

- A digit test is two unsigned compares (listing 01 exits 1 for `'7'`); `expect` matches one byte and advances (listing 05 exits 1 on `'('`). Listing `19-skip-whitespace` skips two spaces and exits the digit **7**. Listing `20-copy-lexeme` copies `"let"` and exits length **3**.
- A list node is value at offset 0 and `next` at offset 8. Walk only after `test` shows a nonzero pointer. Listing 02 exits the count 3; listing 08 exits the sum 12; listing 07 exits the new head value 2.
- A bump arena returns the old cursor and adds the size. Listing 03 exits offset 16; listing 09 exits offset 32. Listing `21-arena-align-bump` rounds 1 up to **8**.
- Explicit stacks and queues are arrays plus indices, not `rsp`. Push 42 / pop is status 42; push 1 / push 2 / pop is status 2; enqueue 7 / 8 / dequeue is status 7.
- A ring wraps with `AND (capacity-1)` after the increment. Listing 15 goes 3 → 4 → 0. Listing 18 computes `7 AND 3 = 3`.
- An AST node is three qwords; listing 16 exits kind+left+right = 6. Listing `22-pratt-binding-power` treats `*` as tighter than `+` and exits **14** for `2 + 3 * 4`.

## Lookup

- Recursive-descent parsing: [Crafting Interpreters, Chapter 6](https://craftinginterpreters.com/parsing-expressions.html)
- Pratt parsing: [Simple but Powerful Pratt Parsing](https://matklad.github.io/2020/04/13/simple-but-powerful-pratt-parsing.html)
- Region-based allocation: [Region-based memory management](https://en.wikipedia.org/wiki/Region-based_memory_management)
- Microsoft x64: first argument in RCX; RSI/RDI nonvolatile — [x64 calling convention](https://learn.microsoft.com/en-us/cpp/build/x64-calling-convention)
- `ExitProcess`: [ExitProcess](https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-exitprocess)

## Exercises

Twenty-four drills under `exercises/`. Solutions mirror the names under `solutions/`. Build from an x64 Native Tools Command Prompt:

```bat
ml64 /c FILE.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE FILE.obj kernel32.lib && FILE.exe
echo %ERRORLEVEL%
```

Lexing: define `TK_NUM EQU 1`, exit 1. Test `'7'`, exit 1. Parse `'3'`, exit 3. Lexeme `'x'`, length 1. Skip spaces in `"  7"`, exit 7. Copy `"let"`, length 3, exit 3. Expect `'('` in `"(1)"`, exit 1. Error offset 4, exit 4.

Lists: one node, value 9, exit 9. Push 1, push 2, exit 2. Sum `3 → 4 → 5`, exit 12. Test before load on an empty list, exit 0.

Memory and tables: two 16-byte allocations, bump 32, exit 32. Mix 5 → 45, exit 45. Store 42 at index 2, exit 42. Align 1 → 8, exit 8. Pointer equality, exit 1. Push three values, exit 3 (no realloc).

Evaluation: push 1, 2, pop, exit 2. Push 2, 3, pop both, add, exit 5. `2 + 3 * 4`, exit 14. AST field sum, exit 6. Enqueue 7, 8, dequeue, exit 7 (FIFO; wrap is a separate drill). Binding power `BP_MUL = 20`, exit 20.
