#!/usr/bin/env python3
"""Single canonical header per exercise; drop stale comment blocks; match solution."""
import re
from pathlib import Path

ROOT = Path("/workspace/lessons")

def sol_metadata(sol: Path):
    if not sol.is_file():
        return None, [], None
    t = sol.read_text(encoding="utf-8")
    em = re.search(r"(?im)^;\s*Expected exit:\s*(.+)$", t)
    if not em:
        return None, [], None
    exit_v = em.group(1).strip()
    desc = []
    for line in t.splitlines()[1:12]:
        if not line.startswith(";"):
            break
        s = line[1:].strip()
        if not s or s.startswith("Build:") or "Expected exit" in s:
            continue
        if s.startswith("Exercise "):
            continue
        desc.append(s)
    sym = re.search(r"(?im)ex_[A-Za-z0-9_]+", t)
    return exit_v, desc, sym.group(0) if sym else None

def ex_symbol(text: str):
    m = re.search(r"EXTRN\s+(ex_[A-Za-z0-9_]+):PROC", text, re.I)
    return m.group(1) if m else None

def code_start_index(text: str) -> int:
    m = re.search(r"^\s*\.(DATA|CODE)\b", text, re.M | re.I)
    if not m:
        return len(text)
    return m.start()

def build_header(stem: str, desc: list[str], sym: str, exit_v: str) -> str:
    lines = [f"; Exercise: {stem}", ";"]
    if desc:
        for d in desc[:4]:
            lines.append(f"; {d}")
    else:
        lines.append(f"; Implement `{sym}` in this file.")
    lines += [
        ";",
        f"; Contract: implement `{sym}` (MS x64). Return exit code in EAX; main passes it to ExitProcess.",
        f"; Expected exit: {exit_v}",
        ";",
        "",
    ]
    return "\n".join(lines)

def reconcile_exercise(path: Path) -> bool:
    sol = path.parent.parent / "solutions" / path.name
    exit_v, desc, sym_sol = sol_metadata(sol)
    if not exit_v:
        return False
    text = path.read_text(encoding="utf-8")
    sym = ex_symbol(text) or sym_sol
    if not sym:
        return False

    if path.name == "11-read-nul.asm":
        code = """.CODE

EXTRN ExitProcess:PROC
EXTRN ex_11_read_nul:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_11_read_nul in this file.
    call    ex_11_read_nul
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
"""
    else:
        code = text[code_start_index(text) :].lstrip("\n")
        if not code.endswith("\n"):
            code += "\n"

    new_text = build_header(path.stem, desc, sym, exit_v) + code
    if new_text != text:
        path.write_text(new_text, encoding="utf-8")
        return True
    return False

def reconcile_solution(path: Path) -> bool:
    exit_v, desc, sym = sol_metadata(path)
    if not exit_v or not sym:
        return False
    text = path.read_text(encoding="utf-8")
    m = re.search(r"^\s*\.(DATA|CODE)\b", text, re.M | re.I)
    if not m:
        return False
    code = text[m.start() :].lstrip("\n")
    if not code.endswith("\n"):
        code += "\n"
    lines = [f"; Exercise: {path.stem}", ";"]
    for d in desc[:4]:
        lines.append(f"; {d}")
    lines += [f"; Expected exit: {exit_v}", ";", ""]
    new_text = "\n".join(lines) + code
    if new_text != text:
        path.write_text(new_text, encoding="utf-8")
        return True
    return False

def main():
    changed = []
    for ex in sorted(ROOT.glob("*/exercises/*.asm")):
        if reconcile_exercise(ex):
            changed.append(ex)
    for sol in sorted(ROOT.glob("*/solutions/*.asm")):
        if reconcile_solution(sol):
            changed.append(sol)
    for p in changed:
        print(p.relative_to(ROOT.parent))
    print(f"Changed {len(changed)} files")

if __name__ == "__main__":
    main()
