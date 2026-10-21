# Lesson 16 — Sprites, Tilemaps, Collision

Lesson 15 gave you time and input. This lesson gives you **space**: row-major tile indices, world-to-tile conversion with a right shift, a two-compare collision probe, the half-open point-in-rectangle rule, a spatial-hash multiply, chunk coordinates, and an animation quotient. By the end you treat 2D game math as indexing, shifts, and interval tests — not as a library.

Every listing is a complete MASM program: `.CODE`, `EXTRN ExitProcess:PROC`, `main PROC` / `main ENDP`, `END`. The process status is the first argument to `ExitProcess` in RCX / ECX.

## What this lesson asks of you

You index a row-major map with `y * width + x` and you convert a world x to a tile column with `shr` by 3 when tiles are 8 pixels (not `div`). You test whether two axis-aligned extents fail a pair of less-than compares, and you state the four-inequality miss test that a full AABB still needs. You hash one shifted coordinate into a cell by multiplying by the row stride, and you take a chunk index with a second shift. You pick an animation frame with unsigned `div` and you read the register the listing actually exits — the quotient in EAX, not a remainder it never consumes. You clip a partially visible sprite (`sx=6`, `sw=8`, `view_w=10`) to width **4**.

## Tile maps: row-major index and world-to-tile

A **tile map** is a 2D grid of tile IDs stored in a flat 1D array, **row-major**: the tile at `(x, y)` lives at index

```
index = y * width + x
```

Listing `02-tilemap-index` uses width 16: `rax = 3`, `rbx = 16`, `imul rax, rbx`, `add rax, 5`. That is `3 * 16 + 5 = 53`. `mov ecx, eax` exits **53**.

```asm
; Listing 02: Tile (tx,ty) to linear index
; Expected exit: 53
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     rax, 3
    mov     rbx, 16
    imul    rax, rbx
    add     rax, 5
    mov     ecx, eax
    call    ExitProcess
main ENDP

END

```

Listing `03-tile-index-formula` is the same formula on 32-bit registers with width 10: `eax = 2`, `imul eax, 10`, `add eax, 3`. `2 * 10 + 3 = 23`. Expected exit: **23**.

```asm
; Listing 03: Tile map index y*w+x
; Expected exit: 23
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    mov eax, 2
    imul eax, 10
    add eax, 3
    mov ecx, eax
    call ExitProcess
main ENDP
END

```

Column-major (`x * height + y`) is a different layout. These two listings are row-major. Swap the multiply and you index the wrong cell.

### World coordinate to tile column

If tiles are 8 pixels wide (a power of two), `tile_x = world_x >> 3` replaces an unsigned divide by 8. Listing `04-world-to-tile` loads 20 into EAX, `shr eax, 3`, and exits. 20 / 8 = 2 remainder 4; the shift drops the remainder. Expected exit: **2**.

```asm
; Listing 04: World x to tile x (>>3)
; Expected exit: 2
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    mov eax, 20
    shr eax, 3
    mov ecx, eax
    call ExitProcess
main ENDP
END

```

A **chunk** is a block of tiles. For chunk size 16, `chunk = tile >> 4`. Listing `08-chunk-coords` shifts 40 right by 4: 40 / 16 = 2. Expected exit: **2**.

```asm
; Listing 08: Chunk coordinate from tile
; Expected exit: 2
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    mov eax, 40
    shr eax, 4
    mov ecx, eax
    call ExitProcess
main ENDP
END

```

40 as a **world** x with tile size 8 would be `40 >> 3 = 5`, then `5 >> 4 = 0` as a chunk. This listing shifts the raw 40 by 4 once, so it is treating 40 as a **tile** index, not as a pixel.

## Axis-aligned boxes: two compares, then the full miss test

An **axis-aligned bounding box** (AABB) is a rectangle whose sides are parallel to the axes, usually stored half-open `[x0, x1) × [y0, y1)`. Two boxes **miss** when one sits completely to one side of the other:

```
miss = (a.x1 <= b.x0) or (b.x1 <= a.x0) or (a.y1 <= b.y0) or (b.y1 <= a.y0)
```

Overlap is the negation: all four inequalities false. Both axes must agree.

Listing `01-aabb-collision` is a **two-compare** probe, not that four-way test. It loads `r8 = 10`, `r9 = 20`, `r10 = 15`, `r11 = 25`, then:

- `cmp r10, r8` / `jl no_collide` — 15 < 10? no.
- `cmp r11, r9` / `jl no_collide` — 25 < 20? no.

Both jumps fall through, so ECX becomes 1. Expected exit: **1**. The `no_collide` path zeros ECX and would exit **0**.

```asm
; Listing 01: AABB overlap test
; Expected exit: 1
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     r8, 10
    mov     r9, 20
    mov     r10, 15
    mov     r11, 25
    cmp     r10, r8
    jl      no_collide
    cmp     r11, r9
    jl      no_collide
    mov     ecx, 1
    jmp     done
no_collide:
    xor     ecx, ecx
done:
    call    ExitProcess
main ENDP

END

```

This listing reports “collide” when the second pair is not strictly less than the first pair on either axis. It does not compare far edges, so two boxes that are far apart on the positive side can still take the collide path. The four-inequality test above is what you write for a real overlap.

Listing `05-aabb-separate-axis` is the miss / separating-axis case as a stub. The comment says the boxes overlap, so there is no miss. The body is `xor ecx, ecx` / `call ExitProcess`. Expected exit: **0**.

```asm
; Listing 05: AABB miss test (separating axis)
; Expected exit: 0
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    ; Boxes overlap: exit 0 (no miss)
    xor ecx, ecx
    call ExitProcess
main ENDP
END

```

A **separating axis** for AABBs is X or Y: if the projections miss on either axis, the boxes miss. This listing does not project; it exits the “no miss” constant.

### Point in a half-open rectangle

A point `(px, py)` is inside `[x0, y0, x1, y1)` when `(x0 <= px < x1) and (y0 <= py < y1)`. That is the degenerate AABB whose width and height are one point.

Listing `06-point-in-rect` comments `px=5 py=5` inside `[0, 10) × [0, 10)` and exits the constant 1. There is no `cmp`. Expected exit: **1**.

```asm
; Listing 06: Point in axis-aligned rectangle
; Expected exit: 1
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    ; px=5 py=5 in [0,10)x[0,10) -> inside
    mov ecx, 1
    call ExitProcess
main ENDP
END

```

Half-open edges make **touching** boxes miss: `a.x1 == b.x0` satisfies `a.x1 <= b.x0`. Pixel `width` in lesson 14 is the same first-outside column.

### Right-edge sprite clip

Listing `10-sprite-clip-margin` clips a sprite against a view. `sx = 6`, `sw = 8`, `view_w = 10`. The left edge is already ≥ 0, so the left adjust is skipped. `sx + sw = 14` is past `view_w`, so `sw = view_w - sx = 4`. The process status is **4**. A non-positive width would take `culled` and exit 1.

```asm
; Listing 10: Clip partially visible sprite width (LESSON.md)
;
; Purpose: sx=6, sw=8, view_w=10 — right edge clips to sw=4.
; Expected exit: 4
; Expected stdout: (none)
;
; Build: ml64 /c /Fo10-sprite-clip-margin.obj 10-sprite-clip-margin.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:10-sprite-clip-margin.exe 10-sprite-clip-margin.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub     rsp, 40

    mov     eax, 6              ; sx
    mov     ebx, 8              ; sw
    mov     ecx, 10             ; view_w

    cmp     eax, 0
    jge     skip_left
    add     ebx, eax            ; sw += sx (sx negative)
    xor     eax, eax
skip_left:
    mov     edx, eax
    add     edx, ebx
    cmp     edx, ecx
    jle     have_width
    mov     ebx, ecx
    sub     ebx, eax            ; sw = view_w - sx
have_width:
    cmp     ebx, 0
    jle     culled
    mov     ecx, ebx
    call    ExitProcess

culled:
    mov     ecx, 1
    call    ExitProcess
main ENDP

END

```

<!-- LISTING-PENDING: 10-sprite-clip-margin.asm -->

## Spatial hash: one shifted coordinate times the stride

A **spatial hash** bins a world position into a grid cell so you test neighbors, not every pair. The usual 2D form is:

```
cell_x = x >> 3
cell_y = y >> 3
index  = cell_y * row_width + cell_x
```

Listing `07-spatial-hash-cell` hashes **one** coordinate. `eax = 40`, `shr eax, 3` → 5, copy to EBX, `eax = 32`, `imul ebx, eax` → `5 * 32 = 160`, `mov ecx, ebx`. Expected exit: **160**.

```asm
; Listing 07: Spatial hash cell index
; Expected exit: 160
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    mov eax, 40
    shr eax, 3
    mov ebx, eax
    mov eax, 32
    imul ebx, eax
    mov ecx, ebx
    call ExitProcess
main ENDP
END

```

There is no second shift and no `+ cell_x`. Read it as `(coord >> 3) * 32`, not as a finished 2D cell index. A later pass can add the other axis; do not invent that add in this listing.

## Animation frame: one unsigned divide, exit the quotient

A looping animation is

```
frame = (time / ticks_per_frame) mod frame_count
```

That is two unsigned `div`s: first `time / ticks` (quotient = how many frames have elapsed in tick units), then that quotient `mod frame_count` (remainder = which cell of the strip). The remainder of the **second** `div` lives in RDX.

Listing `09-anim-frame` performs **one** `div`. `eax = 25`, `ecx = 10`, `xor edx, edx`, `div ecx` → EAX = 2, EDX = 5. Then `mov ecx, eax` — the **quotient**, not the remainder. Expected exit: **2**.

```asm
; Listing 09: Animation frame from tick counter
; Expected exit: 2
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    mov eax, 25
    mov ecx, 10
    xor edx, edx
    div ecx
    mov ecx, eax
    call ExitProcess
main ENDP
END

```

Zero EDX before that `div` (lesson 15). The listing does. It never zeros EDX a second time because there is no second `div`.

## Worked example: why listing 09 exits 2, not a remainder and not 1

**Task:** Turn a tick counter into a frame index. Listing `09-anim-frame` comments “Expected exit: 2”.

**What the instructions do:**

1. `mov eax, 25` / `mov ecx, 10` / `xor edx, edx`.
2. `div ecx` divides `edx:eax` by 10: quotient **2** in EAX, remainder **5** in EDX (25 = 2×10 + 5).
3. `mov ecx, eax` copies the quotient. `ExitProcess` status is **2**.

**Plausible wrong reading:**

*"Animation frame is the remainder after `(time / ticks) mod frames`, so you exit EDX."*

**Why it's wrong:** There is no second `div` and no `mov ecx, edx`. EDX holds 5 (25 mod 10). EAX holds 2. The listing exits EAX. The header is **2**, the quotient.

**The correct reading:** This listing is `time / ticks_per_frame` as an integer frame counter — 25 ticks at 10 ticks/frame = 2 frames elapsed — and that quotient is the status. A wrapping strip still needs a second `div` and an exit from RDX. Do not graft that second divide onto this file.

## Distinctions worth keeping straight

| Confusion | Reality |
|-----------|---------|
| Tile index is `x * width + y` | Listings 02 and 03 compute `y * width + x`. 3×16+5 = **53**; 2×10+3 = **23**. |
| World-to-tile is `div` by 8 | Listing `04-world-to-tile` is `shr eax, 3` on 20, exit **2**. |
| 40 >> 4 is a pixel-to-chunk convert | Listing `08-chunk-coords` shifts 40 once by 4 (tile→chunk), exit **2**. |
| Listing 01 is a four-edge AABB | It is two `jl` compares. This input exits **1**; `no_collide` would exit **0**. |
| Separating-axis listing projects onto X and Y | Listing `05-aabb-separate-axis` is `xor ecx, ecx`, exit **0**. |
| Point-in-rect listing runs four compares | Listing `06-point-in-rect` exits the constant **1**. |
| Spatial hash exits 0 | Listing `07-spatial-hash-cell` computes `(40 >> 3) * 32` and exits **160**. |
| Animation frame is in EDX | Listing `09-anim-frame` exits EAX = 25/10 = **2**. |
| Clip-margin listing insets the box | Listing `10-sprite-clip-margin` clips sx=6, sw=8 against view 10 and exits **4**. |
| Touching half-open boxes overlap | `a.x1 == b.x0` is a miss under `<=`. |

## Check yourself

1. Listing `03-tile-index-formula` does `imul eax, 10` then `add eax, 3` with EAX starting at 2. What index is that, and what would `2 + 10 * 3` (column-major with the same numbers) produce?
2. Listing `04-world-to-tile` shifts 20 right by 3. What pixel range shares that tile column, and why is a `div` by 8 unnecessary here?
3. Listing `01-aabb-collision` compares 15 against 10 and 25 against 20. Which jump would fire if you rewrote the second pair as `r10 = 8` (keep `r8 = 10`), and what would the exit be?
4. After `div ecx` in listing `09-anim-frame`, what is in EAX and what is in EDX? Which one becomes the process status?
5. Listing `07-spatial-hash-cell` shifts 40 by 3 and multiplies by 32. Write the product. What term of `cell_y * row_width + cell_x` is missing?

## Key takeaways

- Row-major tile index is `y * width + x`. Listing `02-tilemap-index` exits **53** (3×16+5); listing `03-tile-index-formula` exits **23** (2×10+3).
- Power-of-two tile size is a shift: listing `04-world-to-tile` does 20 >> 3 and exits **2**. Chunk size 16 is >> 4: listing `08-chunk-coords` exits **2** from 40.
- Listing `01-aabb-collision` is two less-than rejects and exits **1** on (15,25) vs (10,20); the reject path exits **0**. A full overlap test still needs four edges.
- Listing `05-aabb-separate-axis` and listing `06-point-in-rect` are constants (**0** and **1**). Listing `10-sprite-clip-margin` clips to width **4**.
- Listing `07-spatial-hash-cell` computes `(40 >> 3) * 32 = 160`, not a two-axis cell index.
- Listing `09-anim-frame` divides 25 by 10 and exits the **quotient 2**. Remainder 5 stays in EDX and is not the status.

## Lookup

- AABB overlap: [MDN: 2D collision detection](https://developer.mozilla.org/en-US/docs/Games/Techniques/2D_collision_detection)
- Separating Axis Theorem: [Metanet Tutorial: SAT](https://www.metanetsoftware.com/technique/tutorialA.html)
- Spatial hashing: [Spatial hashing](https://web.archive.org/web/20120223230149/http://www.gamedev.net/page/resources/_/technical/game-programming/spatial-hashing-r2697)
- Microsoft x64 calling convention: [x64 calling convention](https://learn.microsoft.com/en-us/cpp/build/x64-calling-convention)

## Exercises

Twenty-four drills under `exercises/`. Solutions mirror the names under `solutions/`. Build from an x64 Native Tools Command Prompt:

```bat
ml64 /c FILE.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE FILE.obj kernel32.lib && FILE.exe
echo %ERRORLEVEL%
```

The Jack listings above are the teaching programs. The drill names under `exercises/` (tile index, AABB overlap, clip width, anim frame, spatial insert, and the rest) are separate student stubs.
