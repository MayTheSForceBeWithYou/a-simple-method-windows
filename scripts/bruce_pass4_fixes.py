#!/usr/bin/env python3
"""Bruce pass 4: headers, alignment, debug cleanup, NASM todo removal."""
import os
import re
from pathlib import Path

ROOT = Path("/workspace")

LINUX_DEAD = re.compile(
    r"^\s*mov\s+rax,\s*60\b.*$|^\s*xor\s+rdi,\s*rdi\b.*$|^\s*; syscall removed.*$",
    re.I | re.M,
)

def expected_from_solution(sol_path: Path) -> tuple[str | None, list[str]]:
    if not sol_path.is_file():
        return None, []
    text = sol_path.read_text(encoding="utf-8")
    m = re.search(r"(?im)^;\s*Expected exit:\s*(.+)$", text)
    exit_line = m.group(1).strip() if m else None
    desc = []
    for line in text.splitlines():
        if line.startswith(";") and "Expected exit" not in line and "Build:" not in line:
            s = line[1:].strip()
            if s and not s.startswith("Exercise "):
                desc.append(s)
            elif s.startswith("Exercise "):
                desc.append(s)
        elif line.strip() and not line.startswith(";"):
            break
    return exit_line, desc[:6]

def ex_symbol(text: str) -> str | None:
    m = re.search(r"EXTRN\s+(ex_[A-Za-z0-9_]+):PROC", text, re.I)
    return m.group(1) if m else None

def fix_debug_dead_code(text: str) -> str:
    text = text.replace("mov rdx, msg", "lea rdx, msg")
    text = text.replace("mov rdx, msg_len", "mov r8d, msg_len")
    text = LINUX_DEAD.sub("", text)
    # collapse extra blank lines
    text = re.sub(r"\n{3,}", "\n\n", text)
    return text

def fix_main_sub_rsp(text: str, force_40_no_push: bool = False) -> str:
    m = re.search(r"(main\s+PROC.*?)(main\s+ENDP)", text, re.S | re.I)
    if not m:
        return text
    body = m.group(1)
    has_nv_push = bool(re.search(r"\bpush\s+(rbx|rbp|r12|r13|r14|r15|rdi|rsi)\b", body, re.I))
    if has_nv_push:
        return text
    new_body = body
    if force_40_no_push or re.search(r"\bsub\s+rsp,\s*32\b", body, re.I):
        new_body = re.sub(r"\bsub\s+rsp,\s*32\b", "sub     rsp, 40", new_body, count=1, flags=re.I)
    if not re.search(r"\bsub\s+rsp\b", new_body, re.I) and re.search(r"\bcall\b", new_body, re.I):
        new_body = re.sub(r"(main\s+PROC)", r"\1\n    sub     rsp, 40", new_body, count=1, flags=re.I)
    if new_body != body:
        text = text[: m.start(1)] + new_body + text[m.end(1) :]
    return text

def build_header(stem: str, ex_sym: str | None, exit_val: str | None, desc_lines: list[str]) -> str:
    lines = [f"; Exercise: {stem}", ";"]
    if desc_lines:
        for d in desc_lines[:4]:
            lines.append(f"; {d}")
    else:
        lines.append(f"; Implement the student routine in this file.")
    lines.append(";")
    if ex_sym:
        lines.append(f"; Contract: implement `{ex_sym}` (MS x64). Return exit code in EAX; main passes it to ExitProcess.")
    if exit_val:
        lines.append(f"; Expected exit: {exit_val}")
    lines.append(";")
    return "\n".join(lines) + "\n\n"

def strip_old_header(text: str) -> str:
    """Remove leading comment block before .CODE/.DATA."""
    m = re.match(r"(?s)((?:;.*\n)+)", text)
    if not m:
        return text
    rest = text[m.end() :]
    if re.match(r"^\s*\.(CODE|DATA)", rest, re.I):
        return rest.lstrip("\n")
    return text

def process_exercise(path: Path) -> bool:
    text = path.read_text(encoding="utf-8")
    orig = text
    lesson = path.parts[path.parts.index("lessons") + 1]
    stem = path.stem
    sol = path.parent.parent / "solutions" / path.name
    exit_val, desc = expected_from_solution(sol)
    sym = ex_symbol(text) or ex_symbol(sol.read_text(encoding="utf-8") if sol.is_file() else "")

    if "debug" in stem or lesson.startswith("00-tools"):
        text = fix_debug_dead_code(text)

    text = text.replace("; TODO: Port from NASM to MASM (MS x64 ABI)", "")
    text = text.replace("; TODO: Port from NASM to MASM", "")
    text = text.replace("; TODO: Port from NASM", "")
    text = re.sub(r"^\s*; TODO: Implement\s*$", "", text, flags=re.M)

    # L04 specific misaligned (no push)
    if lesson == "04-stack-calling-convention":
        text = fix_main_sub_rsp(text, force_40_no_push=True)
    elif lesson == "05-procedures-recursion":
        num = int(stem.split("-")[0]) if stem[:2].isdigit() else 99
        if num <= 10:
            text = fix_main_sub_rsp(text, force_40_no_push=True)
    else:
        text = fix_main_sub_rsp(text)

    if sym and exit_val:
        body = strip_old_header(text)
        header = build_header(stem, sym, exit_val, desc)
        if not re.search(r"(?im)^;\s*Expected exit:", text):
            text = header + body
        elif not re.search(r"(?im)Contract:", text):
            # ensure expected + contract present
            text = header + body

    if text != orig:
        path.write_text(text, encoding="utf-8")
        return True
    return False

def audit_fix_solution_main(path: Path) -> bool:
    text = path.read_text(encoding="utf-8")
    new = fix_main_sub_rsp(text)
    if new != text:
        path.write_text(new, encoding="utf-8")
        return True
    return False

def main():
    n = 0
    for lesson_dir in sorted((ROOT / "lessons").iterdir()):
        exdir = lesson_dir / "exercises"
        if not exdir.is_dir():
            continue
        for asm in sorted(exdir.glob("*.asm")):
            if process_exercise(asm):
                n += 1
        soldir = lesson_dir / "solutions"
        if soldir.is_dir():
            for asm in sorted(soldir.glob("*.asm")):
                if audit_fix_solution_main(asm):
                    n += 1
    print(f"Updated {n} files")

if __name__ == "__main__":
    main()
