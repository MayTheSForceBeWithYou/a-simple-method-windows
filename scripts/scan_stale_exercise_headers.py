#!/usr/bin/env python3
"""Find exercises with stale comment blocks or header contradictions."""
import re
from pathlib import Path

ROOT = Path("/workspace/lessons")

def parse_header_blocks(text: str):
    """Return list of comment blocks before first .CODE/.DATA."""
    m = re.search(r"^\s*\.(CODE|DATA)", text, re.I | re.M)
    if not m:
        return text, []
    pre = text[: m.start()]
    rest = text[m.start() :]
    # split pre into blocks separated by blank lines
    lines = pre.splitlines()
    blocks = []
    cur = []
    for line in lines:
        if line.strip() == "" and cur:
            blocks.append(cur)
            cur = []
        elif line.strip() or cur:
            cur.append(line)
    if cur:
        blocks.append(cur)
    return rest, blocks

def canonical_exit(blocks):
    for b in blocks:
        for line in b:
            if re.match(r";\s*Expected exit:", line, re.I):
                return re.sub(r".*Expected exit:\s*", "", line, flags=re.I).strip()
    return None

def block_text(b):
    return "\n".join(b)

def keywords(s):
    k = set()
    for w in [
        "VirtualAlloc",
        "CreateFile",
        "CreateFileA",
        "HeapAlloc",
        "GetProcessHeap",
        "ReadFile",
        "NUL",
        "GetLastError",
        "CreatePipe",
        "SetFilePointer",
    ]:
        if w.lower() in s.lower():
            k.add(w)
    return k

issues = []

for path in sorted(ROOT.glob("*/exercises/*.asm")):
    text = path.read_text(encoding="utf-8")
    rest, blocks = parse_header_blocks(text)
    if len(blocks) < 2:
        # check duplicate expected exit in whole file
        exits = re.findall(r"(?im)^;\s*Expected exit:\s*(.+)$", text)
        if len(set(exits)) > 1:
            issues.append((path, "duplicate_expected_exit", exits))
        continue

    # First block should be canonical (Exercise: or Contract)
    canon = blocks[0]
    canon_txt = block_text(canon)
    canon_exit = canonical_exit([canon])
    if not canon_exit and len(blocks) > 1:
        canon_exit = canonical_exit(blocks[:2])

    for i, b in enumerate(blocks[1:], 1):
        bt = block_text(b)
        # stale old-style blocks
        if re.search(r"; Task:", bt) or re.search(r"; Hint:", bt):
            if re.search(r";\s*\d{2}-[\w-]+\.asm", bt):
                issues.append((path, "stale_task_block", i))
                continue
        stale_exit = re.findall(r"(?im)^;\s*Expected exit:\s*(.+)$", bt)
        if stale_exit and canon_exit and stale_exit[0].strip() != canon_exit:
            issues.append((path, "conflict_exit", (canon_exit, stale_exit)))

    # API keyword mismatch between block0+1 vs block2+
    if len(blocks) >= 2:
        k0 = keywords(block_text(blocks[0]) + block_text(blocks[1] if "Contract" in block_text(blocks[1]) else ""))
        for b in blocks[1:]:
            bt = block_text(b)
            if "Contract:" in bt and "Expected exit" in bt:
                continue
            k1 = keywords(bt)
            if k0 and k1 and k0 != k1 and k0.isdisjoint(k1) is False:
                pass
            if k0 and k1 and not (k0 & k1) and (k0 | k1):
                # different API families
                if "Task:" in bt or "Open " in bt or "Demonstrate" in bt:
                    issues.append((path, "api_mismatch", (k0, k1)))

    exits = re.findall(r"(?im)^;\s*Expected exit:\s*(.+)$", text)
    if len(set(exits)) > 1:
        issues.append((path, "duplicate_expected_exit", list(set(exits))))

    # EXTRN vs header
    header_all = block_text(blocks[0])
    for b in blocks[1:3]:
        header_all += "\n" + block_text(b)
    extrns = set(re.findall(r"EXTRN\s+(\w+):PROC", text, re.I))
    if "VirtualAlloc" in header_all and "CreateFileA" in extrns:
        issues.append((path, "extrn_createfile_vs_virtualalloc", extrns))
    if "GetProcessHeap" in header_all and "VirtualAlloc" in extrns:
        issues.append((path, "extrn_mismatch_heap", extrns))

for path, kind, detail in issues:
    print(f"{path.relative_to(ROOT.parent)}|{kind}|{detail}")

print("TOTAL", len(issues))
