#!/usr/bin/env python3
import re
from pathlib import Path

ROOT = Path("/workspace/lessons")
LEGACY = [
    "04-stack-calling-convention",
    "05-procedures-recursion",
]

def sol_info(sol: Path):
    t = sol.read_text(encoding="utf-8")
    sym = re.search(r"ex_[A-Za-z0-9_]+", t)
    if not sym:
        return None, None, []
    em = re.search(r"(?im)^;\s*Expected exit:\s*(.+)$", t)
    exit_v = em.group(1).strip() if em else None
    if not exit_v:
        em2 = re.search(r"(?im)Expected:\s*exit code\s*(\d+)", t)
        if em2:
            exit_v = em2.group(1)
    desc = []
    for line in t.splitlines()[:8]:
        if line.startswith(";") and "Build" not in line and "Expected" not in line:
            s = line[1:].strip()
            if s:
                desc.append(s)
    return sym.group(0), exit_v, desc

def convert(ex: Path):
    sol = ex.parent.parent / "solutions" / ex.name
    sym, exit_v, desc = sol_info(sol)
    if not sym or not exit_v:
        print("skip", ex, sym, exit_v)
        return False
    lines = [
        f"; Exercise: {ex.stem}",
        ";",
    ]
    for d in desc[:4]:
        lines.append(f"; {d}")
    lines += [
        ";",
        f"; Contract: implement `{sym}` (MS x64). Return exit code in EAX.",
        f"; Expected exit: {exit_v}",
        ";",
        "",
        ".CODE",
        "",
        "EXTRN ExitProcess:PROC",
        f"EXTRN {sym}:PROC",
        "",
        f"; TODO: write {sym} in this file.",
        "",
        "main PROC",
        "    sub     rsp, 40",
        f"    call    {sym}",
        "    mov     ecx, eax",
        "    call    ExitProcess",
        "main ENDP",
        "",
        "END",
        "",
    ]
    ex.write_text("\n".join(lines), encoding="utf-8")
    return True

def main():
    n = 0
    for lesson in LEGACY:
        exdir = ROOT / lesson / "exercises"
        for ex in sorted(exdir.glob("*.asm")):
            if re.search(r"EXTRN\s+ex_", ex.read_text(), re.I):
                continue
            if convert(ex):
                n += 1
                print(ex)
    print("converted", n)

if __name__ == "__main__":
    main()
