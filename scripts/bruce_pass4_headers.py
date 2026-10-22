#!/usr/bin/env python3
"""Ensure every exercise has task, ex_* contract, and Expected exit from solution."""
import re
from pathlib import Path

ROOT = Path("/workspace/lessons")

def sol_meta(sol: Path):
    if not sol.is_file():
        return None, None, []
    t = sol.read_text(encoding="utf-8")
    em = re.search(r"(?im)^;\s*Expected exit:\s*(.+)$", t)
    exit_v = em.group(1).strip() if em else None
    sym_m = re.search(r"EXTRN\s+(ex_[A-Za-z0-9_]+):PROC", t, re.I)
    sym = sym_m.group(1) if sym_m else None
    desc = []
    for line in t.splitlines()[:12]:
        if line.startswith(";") and "Build:" not in line and "Expected" not in line:
            s = line[1:].strip()
            if s and len(s) > 3:
                desc.append(s)
    return exit_v, sym, desc[:3]

def ensure_header(path: Path) -> bool:
    text = path.read_text(encoding="utf-8")
    sol = path.parent.parent / "solutions" / path.name
    exit_v, sym_sol, desc = sol_meta(sol)
    sym_ex = re.search(r"EXTRN\s+(ex_[A-Za-z0-9_]+):PROC", text, re.I)
    sym = sym_ex.group(1) if sym_ex else sym_sol
    if not exit_v or not sym:
        return False
    has_exit = bool(re.search(r"(?im)^;\s*Expected exit:", text))
    has_contract = "Contract:" in text or "ex_*" in text or f"`{sym}`" in text
    if has_exit and has_contract and re.search(r"(?im)^;\s*Exercise", text):
        return False
    # strip leading comments
    rest = text
    if re.match(r"(?s)(?:;.*\n)+", rest):
        rest = re.sub(r"(?s)^(?:;.*\n)+", "", rest, count=1)
    title = path.stem
    lines = [
        f"; Exercise: {title}",
        ";",
    ]
    for d in desc:
        lines.append(f"; {d}")
    lines += [
        ";",
        f"; Contract: implement `{sym}` (MS x64). Return result in EAX for ExitProcess.",
        f"; Expected exit: {exit_v}",
        ";",
        "",
    ]
    path.write_text("\n".join(lines) + rest, encoding="utf-8")
    return True

def main():
    n = 0
    for ex in sorted(ROOT.glob("*/exercises/*.asm")):
        if ensure_header(ex):
            n += 1
            print(ex)
    print(f"Headers updated: {n}")

if __name__ == "__main__":
    main()
