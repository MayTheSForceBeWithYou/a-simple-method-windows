#!/usr/bin/env python3
"""Convert exercise scaffolds to link-time failure via EXTERN student proc."""
from __future__ import annotations

import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

WINAPI = {
    "ExitProcess",
    "GetStdHandle",
    "WriteFile",
    "ReadFile",
    "CreateFileA",
    "CreateFileW",
    "CloseHandle",
    "GetLastError",
    "Sleep",
    "QueryPerformanceCounter",
    "QueryPerformanceFrequency",
    "VirtualAlloc",
    "VirtualFree",
    "MapViewOfFile",
    "UnmapViewOfFile",
    "CreateFileMappingA",
    "GetCurrentProcessId",
    "SetConsoleMode",
    "GetConsoleMode",
    "FlushFileBuffers",
    "GetModuleHandleA",
    "GetProcAddress",
    "LoadLibraryA",
    "FreeLibrary",
    "MessageBoxA",
    "AllocConsole",
    "GetTickCount64",
    "timeGetTime",
}


def sym_for(path: Path) -> str:
    return "ex_" + path.stem.replace("-", "_")


def proc_defined(text: str, name: str) -> bool:
    return bool(re.search(rf"^\s*{name}\s+PROC\b", text, re.I | re.M))


def has_student_extrn(text: str, sym: str) -> bool:
    return bool(
        re.search(rf"^\s*EXTRN\s+{sym}\s*:\s*PROC", text, re.I | re.M)
        or re.search(rf"^\s*EXTERN\s+{sym}\s*:\s*PROC", text, re.I | re.M)
    )


def asm_calls(text: str) -> list[str]:
    names: list[str] = []
    for line in text.splitlines():
        code = line.split(";", 1)[0]
        for m in re.finditer(r"\bcall\s+([A-Za-z_][A-Za-z0-9_]*)", code, re.I):
            names.append(m.group(1))
    return names


def links_without_student_sym(text: str, sym: str) -> bool:
    """True if this exercise likely links as-is (scaffold must not)."""
    if has_student_extrn(text, sym) or proc_defined(text, sym):
        return False
    for call in asm_calls(text):
        if call in WINAPI:
            continue
        if proc_defined(text, call):
            continue
        # Undefined user/helper symbol -> link error
        return False
    if not re.search(r"\bcall\s+ExitProcess\b", text, re.I | re.M):
        return False
    return True


def insert_extrn(text: str, sym: str) -> str:
    if has_student_extrn(text, sym):
        return text
    m = re.search(r"^(\s*EXTRN\s+\w+\s*:\s*PROC\s*)", text, re.I | re.M)
    if m:
        # After last EXTRN block line
        lines = text.splitlines(keepends=True)
        last_extrn = 0
        for i, line in enumerate(lines):
            if re.match(r"^\s*EXTRN\s+\w+\s*:\s*PROC", line, re.I):
                last_extrn = i
        lines.insert(last_extrn + 1, f"EXTRN {sym}:PROC\n")
        return "".join(lines)
    # Before main PROC
    return re.sub(
        r"(^\s*main\s+PROC)",
        f"EXTRN {sym}:PROC\n\n$1",
        text,
        count=1,
        flags=re.I | re.M,
    )


def extract_main_prolog(main_inner: str) -> tuple[str, str]:
    """Keep shadow-stack / FRAME lines; drop student body."""
    lines = main_inner.splitlines()
    prolog: list[str] = []
    rest_start = 0
    for i, line in enumerate(lines):
        stripped = line.strip().lower()
        if not stripped:
            prolog.append(line)
            rest_start = i + 1
            continue
        if (
            stripped.startswith("sub rsp")
            or stripped.startswith(".allocstack")
            or stripped.startswith(".endprolog")
            or stripped == "main proc"
            or "frame" in stripped
            and "proc" in stripped
        ):
            prolog.append(line)
            rest_start = i + 1
            continue
        if stripped.startswith(";") or stripped.startswith("main proc"):
            prolog.append(line)
            rest_start = i + 1
            continue
        break
    return "\n".join(prolog), "\n".join(lines[rest_start:])


def winapi_extrns_in(text: str) -> list[str]:
    found = set()
    for name in WINAPI:
        if re.search(rf"\b{name}\b", text):
            found.add(name)
    found.add("ExitProcess")
    return sorted(found)


def convert_exercise_text(text: str, sym: str) -> str:
    """Replace .CODE section with link-failing stub; preserve .DATA / header comments."""
    m_code = re.search(r"(?im)^\s*\.CODE\s*$", text)
    if not m_code:
        raise ValueError("no .CODE")
    header = text[: m_code.start()].rstrip() + "\n\n"
    extrns = winapi_extrns_in(text)
    if sym not in extrns:
        extrns = extrns + [sym]
    extrn_block = "\n".join(f"EXTRN {name}:PROC" for name in extrns)
    code = f""".CODE

{extrn_block}

main PROC
    sub     rsp, 40
    ; TODO: implement {sym} (student routine; defined in solutions/).
    call    {sym}
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
"""
    header = re.sub(
        r"\n\s*; TODO: complete exercise[^\n]*\n",
        "\n",
        header,
        flags=re.I,
    )
    return header + code


def parse_expected_exit(text: str) -> str:
    for pat in (
        r"Expected exit:\s*(\d+)",
        r"Expected:\s*exit code\s*(\d+)",
        r"Expected:\s*(\d+)",
    ):
        m = re.search(pat, text, re.I)
        if m:
            return m.group(1)
    return "0"


def body_needs_own_stack(body: str) -> bool:
    return bool(
        re.search(
            r"\b(WriteFile|ReadFile|GetStdHandle|CreateFileA|VirtualAlloc)\b",
            body,
            re.I,
        )
    )


def strip_stack_adjustments(body: str) -> str:
    if body_needs_own_stack(body):
        return body.strip()
    lines = []
    for line in body.splitlines():
        s = line.split(";", 1)[0].strip().lower()
        if s.startswith("sub rsp") or s.startswith("add rsp"):
            continue
        lines.append(line)
    return "\n".join(lines).strip()


def balance_stack_before_ret(body: str) -> str:
    m = re.search(r"sub\s+rsp,\s*(\d+)", body, re.I)
    if not m:
        return body
    n = m.group(1)
    if re.search(rf"add\s+rsp,\s*{n}\b", body, re.I):
        return body
    return body.rstrip() + f"\n    add     rsp, {n}"


def exit_value_from_main_inner(inner: str, fallback: str) -> str:
    m = re.search(
        r"mov\s+(rcx|rax|ecx|eax)\s*,\s*([^\n;]+)\s*\n\s*call\s+ExitProcess",
        inner,
        re.I,
    )
    if m:
        return m.group(2).strip()
    return fallback


def main_stack_reserve(inner: str) -> str:
    m = re.search(r"sub\s+rsp,\s*(\d+)", inner, re.I)
    return m.group(1) if m else "40"


def convert_solution_text(text: str, sym: str) -> str:
    if proc_defined(text, sym) and re.search(
        rf"\bcall\s+{sym}\b", text, re.I
    ):
        return text
    m = re.search(
        r"(?is)(^\s*main\s+PROC[^\n]*\n)(.*?)(^\s*main\s+ENDP\b)",
        text,
        re.M,
    )
    if not m:
        return text
    inner = m.group(2)
    stack = main_stack_reserve(inner)
    exit_val = exit_value_from_main_inner(inner, parse_expected_exit(text))

    student = inner
    exit_m = re.search(
        r"mov\s+(rcx|rax|ecx|eax)\s*,\s*([^\n;]+)\s*\n\s*call\s+ExitProcess",
        student,
        re.I,
    )
    if exit_m:
        reg, val = exit_m.group(1).lower(), exit_m.group(2).strip()
        if reg in ("rcx", "ecx"):
            ret_setup = f"    mov     eax, {val}\n    ret"
        else:
            ret_setup = f"    mov     eax, {val}\n    ret"
        student = re.sub(
            r"mov\s+(rcx|rax|ecx|eax)\s*,\s*[^\n]+\s*\n\s*call\s+ExitProcess",
            ret_setup,
            student,
            count=1,
            flags=re.I,
        )
    else:
        student = re.sub(
            r"(?im)^\s*call\s+ExitProcess\s*$",
            f"    mov     eax, {exit_val}\n    ret",
            student,
            count=1,
        )

    proc = f"{sym} PROC\n{student}\n{sym} ENDP\n"
    if re.search(r"\bsub\s+rsp\b", student, re.I):
        main_prolog = ""
    else:
        main_prolog = f"    sub     rsp, {stack}\n"
    new_main = f"""main PROC
{main_prolog}    call    {sym}
    mov     rcx, rax
    call    ExitProcess
main ENDP"""
    return text[: m.start()] + proc + new_main + text[m.end() :]


def fix_main_proc_formatting(text: str) -> str:
    return re.sub(
        r"(?m)^(main\s+PROC)\s+(sub\s+rsp)",
        r"$1\n    $2",
        text,
        flags=re.I,
    )


def should_convert(text: str, sym: str) -> bool:
    if has_student_extrn(text, sym):
        if re.search(r"main\s+PROC\s+sub\s+rsp", text, re.I):
            return True
        if re.search(r"mov\s+ecx,\s*[01]\s*\n\s*call\s+ExitProcess", text, re.I):
            return True
        if re.search(r"^\s*\w+\s+PROC\b", text, re.I | re.M) and not proc_defined(
            text, sym
        ):
            # Helper PROC left in scaffold (still links)
            for name in re.findall(r"^\s*(\w+)\s+PROC\b", text, re.I | re.M):
                if name.lower() != "main":
                    return True
        return False
    return links_without_student_sym(text, sym)


def main() -> None:
    converted: list[dict[str, str]] = []
    for ex_path in sorted(ROOT.glob("lessons/**/exercises/*.asm")):
        raw = ex_path.read_text(encoding="utf-8")
        text = fix_main_proc_formatting(raw)
        sym = sym_for(ex_path)
        if not should_convert(text, sym):
            if text != raw:
                ex_path.write_text(text, encoding="utf-8")
            continue
        new_text = fix_main_proc_formatting(convert_exercise_text(text, sym))
        ex_path.write_text(new_text, encoding="utf-8")
        sol_path = ex_path.parent.parent / "solutions" / ex_path.name
        if sol_path.exists():
            sol_text = sol_path.read_text(encoding="utf-8")
            new_sol = convert_solution_text(sol_text, sym)
            if new_sol != sol_text:
                sol_path.write_text(new_sol, encoding="utf-8")
        converted.append(
            {
                "exercise": str(ex_path.relative_to(ROOT)),
                "extern": sym,
                "solution": str(sol_path.relative_to(ROOT))
                if sol_path.exists()
                else "",
            }
        )

    out_path = ROOT / "scripts" / "scaffold-conversions.json"
    # Merge with prior conversions (first run) by exercise path
    if out_path.exists():
        prior = json.loads(out_path.read_text(encoding="utf-8"))
        by_ex = {row["exercise"]: row for row in prior}
        for row in converted:
            by_ex[row["exercise"]] = row
        converted = sorted(by_ex.values(), key=lambda r: r["exercise"])
    out_path.write_text(json.dumps(converted, indent=2) + "\n", encoding="utf-8")
    print(f"Converted {len(converted)} exercises -> {out_path}")
    for row in converted[:15]:
        print(f"  {row['extern']}: {row['exercise']}")
    if len(converted) > 15:
        print(f"  ... and {len(converted) - 15} more")


if __name__ == "__main__":
    main()
