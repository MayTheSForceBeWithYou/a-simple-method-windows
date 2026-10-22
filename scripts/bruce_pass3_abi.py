#!/usr/bin/env python3
"""Add/fix sub rsp in exercise scaffolds (MS x64 main alignment)."""
import os
import re

def lesson_num(name: str) -> int:
    return int(name.split("-")[0])

def fix_file(path: str, num: int) -> bool:
    text = open(path, encoding="utf-8").read()
    if "EXTRN ex_" not in text and "EXTERN ex_" not in text:
        return False
    m = re.search(r"(main\s+PROC)(.*?)(main\s+ENDP)", text, re.S | re.I)
    if not m:
        return False
    body = m.group(2)
    has_push_nv = bool(
        re.search(r"\bpush\s+(rbx|rbp|r12|r13|r14|r15|rdi|rsi)\b", body, re.I)
    )
    new_body = body
    changed = False

    if num >= 11:
        if not re.search(r"\bsub\s+rsp\b", body, re.I):
            if re.search(r"\bcall\b", body, re.I):
                new_body = "\n    sub     rsp, 40" + body
                changed = True
    else:
        if not re.search(r"\bsub\s+rsp\b", body, re.I):
            if re.search(r"\bcall\b", body, re.I):
                new_body = "\n    sub     rsp, 40" + body
                changed = True
        elif has_push_nv:
            pass  # push + sub 32 is correct; do not auto-edit
        elif re.search(r"\bsub\s+rsp,\s*32\b", body, re.I):
            new_body = re.sub(
                r"sub\s+rsp,\s*32\b",
                "sub     rsp, 40",
                body,
                count=1,
                flags=re.I,
            )
            changed = new_body != body

    if not changed:
        return False
    new_text = text[: m.start(2)] + new_body + text[m.end(2) :]
    open(path, "w", encoding="utf-8").write(new_text)
    return True

def main():
    n = 0
    for lesson in sorted(os.listdir("lessons")):
        if not lesson[:2].isdigit():
            continue
        num = lesson_num(lesson)
        if num > 18:
            continue
        exdir = os.path.join("lessons", lesson, "exercises")
        if not os.path.isdir(exdir):
            continue
        for fn in os.listdir(exdir):
            if fn.endswith(".asm"):
                p = os.path.join(exdir, fn)
                if fix_file(p, num):
                    n += 1
    print(f"Updated {n} files")

if __name__ == "__main__":
    main()
