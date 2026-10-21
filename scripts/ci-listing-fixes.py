#!/usr/bin/env python3
"""One-shot listing fixes for Windows ml64 CI (run from repo root)."""
from __future__ import annotations

import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def patch_file(rel: str, fn) -> bool:
    path = ROOT / rel
    text = path.read_text(encoding="utf-8")
    new = fn(text)
    if new != text:
        path.write_text(new, encoding="utf-8")
        return True
    return False


def replace_all(text: str, pairs: list[tuple[str, str]]) -> str:
    for a, b in pairs:
        text = text.replace(a, b)
    return text


def fix_l10_length(text: str) -> str:
    return text.replace("length", "buf_len")


def fix_reserved_renames(text: str, mapping: dict[str, str]) -> str:
    for old, new in mapping.items():
        # word boundaries for identifiers
        text = re.sub(rf"\b{old}\b", new, text)
    return text


def fix_0x_literals(text: str) -> str:
    text = re.sub(r"\b0x([0-9A-Fa-f]+)\b", lambda m: f"{m.group(1)}h", text)
    text = re.sub(r"\b0b([01]+)\b", lambda m: f"{m.group(1)}b", text)
    return text


def fix_indexed_data(text: str, label: str) -> str:
    """Use RIP-relative base in r10 for label[reg*scale] and label[reg]."""
    if label not in text:
        return text
    if f"lea r10, {label}" in text:
        return text
    # label[reg*8]
    text = re.sub(
        rf"\b{label}\[([a-zA-Z0-9_]+)\*8\]",
        rf"[r10+\1*8]",
        text,
    )
    text = re.sub(
        rf"\bBYTE PTR {label}\[([a-zA-Z0-9_]+)\]",
        rf"BYTE PTR [r10+\1]",
        text,
    )
    text = re.sub(
        rf"\bQWORD PTR {label}\[([a-zA-Z0-9_]+)\]",
        rf"QWORD PTR [r10+\1]",
        text,
    )
    text = re.sub(
        rf"\bBYTE PTR {label}\[([a-zA-Z0-9_]+)\]",
        rf"BYTE PTR [r10+\1]",
        text,
    )
    text = re.sub(
        rf"\bBYTE PTR buf\[([a-zA-Z0-9_]+)\]",
        rf"BYTE PTR [r10+\1]",
        text,
    )
    if f"lea r10, {label}" not in text and re.search(rf"\[r10\+", text):
        # insert lea after main PROC block entry (after sub rsp or first line of main)
        text = re.sub(
            r"(main PROC[^\n]*\n(?:\s+push[^\n]+\n|\s+\.pushreg[^\n]+\n|\s+sub rsp[^\n]+\n|\s+\.allocstack[^\n]+\n|\s+\.endprolog\n)*)",
            lambda m: m.group(1) + f"    lea     r10, {label}\n",
            text,
            count=1,
        )
    return text


def main() -> None:
    changed: list[str] = []

    # ml64 literal syntax
    for rel in [
        "lessons/01-addressing-data/listings/08-size-specifiers.asm",
        "lessons/07-bitops-shifts-masks/listings/01-bit-operations.asm",
        "lessons/02-arithmetic-flags/listings/08-test-instruction.asm",
    ]:
        if patch_file(rel, fix_0x_literals):
            changed.append(rel)

    # L10 length
    for rel in [
        "lessons/10-milestone-cli-editor/listings/01-buffer-append.asm",
        "lessons/10-milestone-cli-editor/listings/02-insert-middle.asm",
        "lessons/10-milestone-cli-editor/listings/03-delete-forward.asm",
        "lessons/10-milestone-cli-editor/listings/04-cursor-clamp.asm",
    ]:
        if patch_file(rel, fix_l10_length):
            changed.append(rel)

    # Reserved names
    reserved_files: list[tuple[str, dict[str, str]]] = [
        (
            "lessons/12-milestone-tiny-compiler/listings/05-bytecode-stack.asm",
            {"code": "bytecode", "st": "stack_mem", "sp_": "stack_sp"},
        ),
        (
            "lessons/12-milestone-tiny-compiler/listings/06-bytecode-jmp.asm",
            {"code": "bytecode"},
        ),
        (
            "lessons/14-graphics-framebuffer/listings/10-bresenham-pixel-count.asm",
            {"dx": "delta_x", "dy": "delta_y"},
        ),
        (
            "lessons/18-capstone-park-sim/listings/04-map-grid-bss.asm",
            {"width": "grid_w", "height": "grid_h", "map": "tilemap"},
        ),
        (
            "lessons/18-capstone-park-sim/listings/05-clamp-x-signed.asm",
            {"width": "grid_w"},
        ),
        (
            "lessons/18-capstone-park-sim/listings/06-clamp-x-unsigned.asm",
            {"width": "grid_w"},
        ),
        (
            "lessons/11-parsing-datastructures/listings/13-stack-push-pop.asm",
            {"sp": "stack_sp"},
        ),
        (
            "lessons/17-entities-pathfinding-ui/listings/08-bfs-visit-count.asm",
            {"queue": "bfs_queue"},
        ),
    ]
    for rel, mapping in reserved_files:
        if patch_file(rel, lambda t, m=mapping: fix_reserved_renames(t, m)):
            changed.append(rel)

    # Indexed DATA labels (ADDR32)
    index_labels = [
        ("lessons/11-parsing-datastructures/listings/04-stack-push-pop.asm", "stack_data"),
        ("lessons/11-parsing-datastructures/listings/10-vector-push.asm", "vec_data"),
        ("lessons/11-parsing-datastructures/listings/13-stack-push-pop.asm", "stk"),
        ("lessons/11-parsing-datastructures/listings/14-queue-fifo.asm", "q"),
        ("lessons/11-parsing-datastructures/listings/17-queue-ops-sequence.asm", "q"),
        ("lessons/10-milestone-cli-editor/listings/05-append-advance-cursor.asm", "buf"),
        ("lessons/10-milestone-cli-editor/listings/07-insert-middle-shift.asm", "buf"),
        ("lessons/10-milestone-cli-editor/listings/08-delete-forward-shift.asm", "buf"),
        ("lessons/10-milestone-cli-editor/listings/11-gap-insert-byte.asm", "buf"),
        ("lessons/10-milestone-cli-editor/listings/12-gap-move-left.asm", "buf"),
        ("lessons/10-milestone-cli-editor/listings/13-gap-move-right.asm", "buf"),
        ("lessons/10-milestone-cli-editor/listings/14-line-start-scan.asm", "buf"),
        ("lessons/10-milestone-cli-editor/listings/20-insert-shift-jl.asm", "buf"),
        ("lessons/14-graphics-framebuffer/listings/04-blit-key-copy.asm", "src"),
        ("lessons/14-graphics-framebuffer/listings/05-write-ppm-p6.asm", "px"),
        ("lessons/17-entities-pathfinding-ui/listings/05-entity-update-soa.asm", "xs"),
    ]
    for rel, label in index_labels:
        if patch_file(rel, lambda t, lb=label: fix_indexed_data(t, lb)):
            changed.append(rel)

    # entity-update also uses vxs
    rel = "lessons/17-entities-pathfinding-ui/listings/05-entity-update-soa.asm"
    if patch_file(rel, lambda t: fix_indexed_data(t, "vxs")):
        if rel not in changed:
            changed.append(rel)

    # BFS visited array + head/tail cmp
    rel = "lessons/17-entities-pathfinding-ui/listings/08-bfs-visit-count.asm"
    def fix_bfs(t: str) -> str:
        t = fix_indexed_data(t, "bfs_queue")
        t = fix_indexed_data(t, "visited")
        t = t.replace("cmp     head, tail", "mov     rax, QWORD PTR head\n    cmp     rax, QWORD PTR tail")
        return t
    if patch_file(rel, fix_bfs):
        changed.append(rel)

    print("Patched", len(changed), "files")
    for c in sorted(set(changed)):
        print(" ", c)


if __name__ == "__main__":
    main()
