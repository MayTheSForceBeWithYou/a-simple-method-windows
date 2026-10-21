# Lesson 17 — Entities, Pathfinding, UI

Lesson 16 gave you tiles and boxes. This lesson gives you **entities** as parallel arrays (structure-of-arrays), a one-axis absolute difference for A*’s heuristic, component bit flags, a focus index that wraps with `inc` then `div`, and a stat clamp that runs **after** the add. By the end you treat an entity-component table as indexed arrays, not as objects, and you refuse to store a happiness of 110.

## What this lesson asks of you

You integrate velocity into position for one entity and for a live subset of a SoA table, skipping dead slots. You declare `xs`, `ys`, `vxs`, and `alive` as parallel storage and you exit 0 from a declaration-only program. You OR component bits (`POS | VEL | HP`) into a mask. You take an absolute difference with a sign test (the one-axis half of Manhattan). You wrap a focus index with `(focus + 1) mod count` by incrementing first, then using the **remainder** in RDX. You clamp a guest stat after arithmetic, not before.

## One entity: x += vx

An **entity** is an integer id. Its position and velocity are QWORDs you update each tick: `x = x + vx`. Listing `01-entity-update` stores `entity_x = 100`, `entity_vx = 5`, adds them in RAX, writes the sum back, and exits the low 32 bits. 100 + 5 = 105. Expected exit: **105** (the new x).

```asm
; Update entity position, exit new x
.DATA?
entity_x QWORD ?
entity_vx QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    mov entity_x, 100
    mov entity_vx, 5
    mov rax, entity_x
    add rax, entity_vx
    mov entity_x, rax
    mov ecx, eax
    call ExitProcess
main ENDP
END

```

There is no `y`, no alive flag, and no loop. The next listings add those.

## Structure of arrays: declare, then update the live slots

**Array-of-structures** (AoS, lesson 06) stores one entity as a contiguous record: `x, y, vx, …` then the next entity. **Structure-of-arrays** (SoA) stores one field across all entities:

```
xs:    x0, x1, x2, …
ys:    y0, y1, y2, …
vxs:   vx0, vx1, vx2, …
alive: a0, a1, a2, …
```

A system that only touches `xs` and `vxs` streams two arrays. AoS would skip `y` and the rest on every iteration.

Listing `03-soa-field-decl` is that layout: `xs` = 0, 5, 0; `ys` = 0, 6, 0; `vxs` = 1, 2, 3; `alive` = 1, 0, 1. Entity 1’s position would be `(xs[1], ys[1])` = (5, 6) at byte offsets +8. The body does not read those arrays. It zeros ECX and exits. Expected exit: **0**.

```asm
; Listing 03: Structure-of-arrays field declarations (LESSON.md block 3)
; Expected exit: 0
; Expected stdout: (none)

.DATA
xs DQ 0, 5, 0
ys DQ 0, 6, 0
vxs DQ 1, 2, 3
alive DB 1, 0, 1

.CODE
EXTRN ExitProcess:PROC

main PROC
    xor     ecx, ecx
    call    ExitProcess
main ENDP
END

```

Listing `05-entity-update-soa` runs the per-tick loop on three slots:

- `rcx` is the index, 0..2.
- `alive` is bytes: `cmp BYTE PTR alive[rcx], 0` / `je next` skips the dead.
- `xs` and `vxs` are QWORDs: `vxs[rcx*8]` and `xs[rcx*8]` scale by 8.
- Live slots add velocity into position.

Slot 0 is alive: `xs[0] += 1` → 1.  
Slot 1 is dead: skipped.  
Slot 2 is alive: `xs[2] += 3` → 3.

The checksum is `xs` (slot 0) + `xs[16]` (slot 2, +16 bytes). 1 + 3 = 4. Expected exit: **4**.

```asm
; Listing 05: SoA entity update loop (LESSON.md block 5)
; Expected exit: 4
; Expected stdout: (none)

.DATA
xs DQ 0, 0, 0
vxs DQ 1, 2, 3
alive DB 1, 0, 1

.CODE
EXTRN ExitProcess:PROC

main PROC
    xor     rcx, rcx
loop_start:
    cmp     rcx, 3
    jge     done
    cmp     BYTE PTR alive[rcx], 0
    je      next
    mov     rax, vxs[rcx*8]
    add     xs[rcx*8], rax
next:
    inc     rcx
    jmp     loop_start
done:
    mov     rax, xs
    add     rax, xs[16]
    mov     ecx, eax
    call    ExitProcess
main ENDP
END

```

The scale factor follows the element size. `alive[rcx]` is one byte per entity; `xs[rcx*8]` is eight. Mixing those scales reads the wrong slot.

## Component flags as an OR of bits

A **component mask** is a byte (or dword) where each bit is a component. Listing `04-component-flag-bits` defines `POS EQU 1`, `VEL EQU 2`, `HP EQU 4` and executes `mov eax, POS OR VEL OR HP`. MASM `OR` here is the assemble-time operator, not the `or` instruction. 1 | 2 | 4 = 7. Expected exit: **7**.

```asm
; Listing 04: ECS component flag bits (LESSON.md block 4)
; Expected exit: 7
; Expected stdout: (none)

POS EQU 1
VEL EQU 2
HP  EQU 4

.CODE
EXTRN ExitProcess:PROC

main PROC
    mov     eax, POS OR VEL OR HP
    mov     ecx, eax
    call    ExitProcess
main ENDP
END

```

An entity that has position and velocity and not health would store 3. Test a single bit with `test mask, POS`, not `cmp mask, POS` — `cmp` against 1 rejects a mask of 3 even though bit 0 is set.

## Manhattan as an absolute difference (one axis)

A*’s heuristic `h` on a 4-neighbor grid is **Manhattan** distance `|dx| + |dy|`. It is admissible for unit cost (never overestimates), so the first time A* expands the goal the path is optimal. `f = g + h` where `g` is cost already paid.

Listing `02-manhattan-dist` computes **one** absolute difference: `rax = 10`, `rbx = 5`, `sub rax, rbx` → 5, `test rax, rax` / `jns pos1` skips `neg` because 5 is non-negative, then `mov ecx, eax`. Expected exit: **5**. There is no second axis and no add of `|dy|`.

```asm
; Manhattan distance for A*, exit dist
.CODE
EXTRN ExitProcess:PROC
main PROC
    mov rax, 10
    mov rbx, 5
    sub rax, rbx
    test rax, rax
    jns pos1
    neg rax
pos1:
    mov ecx, eax
    call ExitProcess
main ENDP
END

```

The sign test is the same rule as lesson 15’s mouse delta. Reverse the operands (`5 - 10`) and `neg` runs. A full `h` still needs `|x2 - x1| + |y2 - y1|`.

<!-- LISTING-PENDING: no Jack listing for BFS queue/visited/parent, A* f = g+h, or a two-axis Manhattan add; 02-manhattan-dist.asm is |10-5| only -->

## Focus wrap: increment, then remainder

UI **focus** is the selected widget index. It wraps:

```
focus = (focus + 1) mod widget_count
```

Listing `06-focus-wrap-div` starts `focus = 2`, increments to 3, loads that into RAX, zeros RDX, divides by 3. 3 / 3 = quotient 1, **remainder 0**. `mov ecx, edx` exits the remainder. Expected exit: **0**.

```asm
; Listing 06: Focus index wrap with div (LESSON.md block 6)
; Expected exit: 0
; Expected stdout: (none)

.DATA?
focus QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    mov     focus, 2
    inc     focus
    mov     rax, focus
    xor     rdx, rdx
    mov     rbx, 3
    div     rbx
    mov     ecx, edx
    call    ExitProcess
main ENDP
END

```

`inc` then `mod`, not `mod` then `inc`. If focus is already 2, `(2 + 1) mod 3 = 0` wraps to the first widget. `(2 mod 3) + 1 = 3` is past the last valid index (0..2). Zero RDX before the `div` (lesson 15). The remainder is the wrapped index; the quotient is how many times you wrapped, which this listing discards.

<!-- LISTING-PENDING: no Jack listing for a four-compare UI hit test or panel y-cursor stack; focus wrap is listing 06 -->

## Worked example: clamp happiness after the add

**Task:** Happiness starts at 90. A bonus of 20 must not leave a stored value above 100. Listing `07-happiness-clamp` is that clamp.

```asm
; Listing 07: Clamp happiness after bonus (LESSON.md block 7)
; Expected exit: 100
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    mov     rax, 90
    add     rax, 20
    cmp     rax, 100
    jle     ok
    mov     rax, 100
ok:
    mov     ecx, eax
    call    ExitProcess
main ENDP
END

```

**What the instructions do:**

1. `mov rax, 90` / `add rax, 20` → 110.
2. `cmp rax, 100` / `jle ok` — 110 is **not** ≤ 100, so the jump is not taken.
3. `mov rax, 100`.
4. `mov ecx, eax` / `call ExitProcess`. Expected exit: **100**.

**Plausible wrong reading:**

*"Clamping keeps the stored stat valid, so clamp 90 first (already ≤ 100), then add the bonus."*

**Why it's wrong:** Clamping 90 does nothing. `add rax, 20` then stores 110. The invariant “happiness ≤ 100” is broken after every bonus that crosses the cap.

**The correct reading:** Clamp the **result** of the arithmetic, immediately before you store or exit. Lesson 18’s cash uses the same order: compare, then subtract, not subtract and hope.

`jle` is signed. 110 compared to 100 as signed values is greater, so the clamp writes 100. An unsigned `jbe` would make the same decision for these two positive numbers.

## Distinctions worth keeping straight

| Confusion | Reality |
|-----------|---------|
| SoA and AoS are the same layout | SoA is parallel arrays (listing `03-soa-field-decl`). AoS is one record per entity. |
| Every slot updates | Listing `05-entity-update-soa` skips `alive == 0`. Dead slot 1 does not add 2. Checksum **4**, not 6. |
| `xs[rcx]` is the QWORD at entity `rcx` | QWORD elements need `xs[rcx*8]`. Bytes use `alive[rcx]`. |
| `cmp mask, POS` tests bit 0 | `cmp` against 1 rejects mask 3. Use `test`. Listing `04-component-flag-bits` ORs bits to **7**. |
| Manhattan needs a square root | Manhattan is `|dx| + |dy|`. Listing `02-manhattan-dist` is `|10 - 5|` = **5**, one axis. |
| Focus is `mod` then `inc` | Listing `06-focus-wrap-div` increments 2 to 3, then exits RDX = **0**. |
| Clamp the operand, then add | Listing `07-happiness-clamp` adds first (110), then writes 100. Exit **100**. |
| Entity update exits a flag | Listing `01-entity-update` exits the new **x** (105). |

## Check yourself

1. In listing `05-entity-update-soa`, why is the index scaled by 8 for `xs` / `vxs` and not for `alive`? What checksum would you get if you forgot the `alive` skip?
2. Listing `06-focus-wrap-div` starts at 2 with a divisor of 3. What is in RAX and RDX after `div`, and why would `div` then `inc` produce an illegal index?
3. Listing `07-happiness-clamp` uses `cmp rax, 100` / `jle ok` **after** `add rax, 20`. What is stored if you move that compare-and-branch above the add, starting from 90?
4. Listing `02-manhattan-dist` subtracts 5 from 10. What extra instructions would a second axis `dy = 3 - 8` need, and what would `|dx| + |dy|` be?
5. Listing `03-soa-field-decl` exits 0. What is entity 1’s `(x, y)` in that `.DATA`, and why is that pair not the process status?

## Key takeaways

- One entity integrates with `x += vx`. Listing `01-entity-update` exits the new x, **105**.
- SoA is parallel arrays. Listing `03-soa-field-decl` declares them and exits **0**. Listing `05-entity-update-soa` updates live slots only and exits checksum **4**.
- Component bits OR together. Listing `04-component-flag-bits` exits `POS | VEL | HP` = **7**.
- Listing `02-manhattan-dist` is a signed absolute difference of 10 and 5, exit **5** — one axis of `h`, not `|dx| + |dy|`.
- Focus wraps with increment then remainder: listing `06-focus-wrap-div` turns 2 into **0** via `div` by 3 and `mov ecx, edx`.
- Clamp after arithmetic. Listing `07-happiness-clamp` turns 90 + 20 into **100**.

## Lookup

- Data-oriented layout: [Reading bits of a data structure (the cache)](https://fgiesen.wordpress.com/2018/02/19/reading-bits-of-a-data-structure-the-cache/)
- A* and grids: [Red Blob Games: Introduction to A*](https://www.redblobgames.com/pathfinding/a-star/introduction.html)
- Manhattan / taxicab geometry: [Taxicab geometry](https://en.wikipedia.org/wiki/Taxicab_geometry)
- Microsoft x64 calling convention: [x64 calling convention](https://learn.microsoft.com/en-us/cpp/build/x64-calling-convention)

## Exercises

Twenty-four drills under `exercises/`. Solutions mirror the names under `solutions/`. Build from an x64 Native Tools Command Prompt:

```bat
ml64 /c FILE.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE FILE.obj kernel32.lib && FILE.exe
echo %ERRORLEVEL%
```

The Jack listings above are the teaching programs. The drill names under `exercises/` (SoA position, BFS distance, UI hit, guest happiness, and the rest) are separate student stubs.
