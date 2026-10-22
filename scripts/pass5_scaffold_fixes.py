#!/usr/bin/env python3
import re
from pathlib import Path

ROOT = Path("/workspace/lessons")

# --- EXTERNDEF ---
def externdef_all():
    n = 0
    for p in ROOT.glob("*/exercises/*.asm"):
        t = p.read_text(encoding="utf-8")
        t2 = re.sub(r"\bEXTRN\s+(ex_[A-Za-z0-9_]+)\s*:\s*PROC", r"EXTERNDEF \1:PROC", t)
        if t2 != t:
            p.write_text(t2, encoding="utf-8")
            n += 1
    print("EXTERNDEF", n)

# --- Remove jmp __ex_call dead blocks ---
def strip_debug_dead():
    n = 0
    for p in ROOT.glob("*/exercises/*.asm"):
        t = p.read_text(encoding="utf-8")
        if "jmp     __ex_call" not in t and "jmp __ex_call" not in t:
            continue
        t2 = re.sub(
            r"\s*; Broken starter.*?\n\s*jmp\s+__ex_call\s*\n.*?(?=__ex_call:\s*\n)",
            "\n    ; BUG: see exercise description; implement fix in student routine.\n",
            t,
            flags=re.S,
        )
        if "__ex_call:" not in t2 and re.search(r"\bjmp\s+__ex_call\b", t2):
            t2 = re.sub(
                r"(\n)(\s*; TODO: write ex_.*?\n\s*call\s+ex_)",
                r"\n__ex_call:\2",
                t2,
                count=1,
            )
        else:
            t2 = re.sub(r"\s*__ex_call:\s*\n", "\n", t2)
        if t2 != t:
            p.write_text(t2, encoding="utf-8")
            n += 1
            print("dead", p.relative_to(ROOT.parent))
    print("strip_debug_dead", n)

HELPER_TASKS = {
    "02-call-ret-leaf.asm": "Implement leaf `answer` returning 42 in RAX. In `ex_02_call_ret_leaf`, call `answer` and return that value as the process exit code.",
    "03-add-two-args.asm": "Implement `add2(rcx, rdx)` returning sum in RAX. In `ex_03_add_two_args`, call `add2(10, 32)` and exit with the result (42).",
    "04-six-args-sum.asm": "Implement `sum6` using MS x64 register args RCX,RDX,R8,R9 and stack slots [rsp+32],[rsp+40]. In `ex_04_six_args_sum`, pass 1..6 and exit with the sum (21).",
    "05-seventh-stack-arg.asm": "Implement `sum7(a..g)`: RCX,RDX,R8,R9 plus stack args at caller [rsp+32],[rsp+40],[rsp+48] (callee sees them at [rsp+40],[rsp+48],[rsp+56] after the call). In `ex_05_seventh_stack_arg`, pass 1..7 and exit 28. Main uses `sub rsp,40`; student setup may use `sub rsp,56` before `call sum7`.",
    "06-prologue-locals.asm": "Implement `sum_locals(rcx)` with three QWORD locals summing rcx+1..rcx+3. In `ex_06_prologue_locals`, call with 10 and exit 33.",
    "10-factorial-iter-proc.asm": "Implement iterative `factorial(n)` in a PROC. In `ex_10_factorial_iter_proc`, compute fact(5) and exit 120.",
    "11-recursion-fact.asm": "Implement recursive `factorial`. In `ex_11_recursion_fact`, exit with fact(5)=120.",
    "12-recursion-fib.asm": "Implement recursive `fib`. In `ex_12_recursion_fib`, exit with fib(7)=13.",
    "20-strlen-proc.asm": "Implement `strlen` on `walkMsg`. In `ex_20_strlen_proc`, exit with string length (8).",
    "26-print-via-helper.asm": "Implement `print_msg` using WriteFile on stdout. In `ex_26_print_via_helper`, print `walkMsg` and exit 0.",
    "01-locals-three.asm": "Implement `sum_locals` with three QWORD locals. In `ex_01_locals_three`, call with 10 and exit 33.",
    "02-mutual-even-odd.asm": "Implement mutual `even`/`odd` helpers. In `ex_02_mutual_even_odd`, exit whether 4 is even (1).",
    "03-rec-sum.asm": "Implement recursive `sum_to(n)`. In `ex_03_rec_sum`, exit sum_to(5)=15.",
}

HEADER_FIXES = [
    (r"lessons/00-tools-registers-mov-syscall/exercises/04-zero-with-xor.asm", [
        (r"\brdi\b", "RCX"),
        (r"\bdil\b", "CL"),
    ]),
    (r"lessons/00-tools-registers-mov-syscall/exercises/05-mov-chain.asm", [
        (r"\brdi\b", "RCX"),
    ]),
    (r"lessons/00-tools-registers-mov-syscall/exercises/08-two-writes.asm", [
        (r"write syscalls", "WriteFile calls"),
        (r"syscall", "Win32 API"),
    ]),
    (r"lessons/11-parsing-datastructures/exercises/07-stack-ds.asm", [
        (r"pop to rdi", "pop into RCX"),
        (r"\brdi\b", "RCX"),
    ]),
    (r"lessons/05-procedures-recursion/exercises/12-rec-binary-digits.asm", [
        (r"\brdi\b", "RCX"),
        (r"\brsi\b", "RDX"),
    ]),
    (r"lessons/05-procedures-recursion/exercises/17-fold-list.asm", [
        (r"\brdi\b", "RCX"),
        (r"\brsi\b", "RDX"),
    ]),
    (r"lessons/05-procedures-recursion/exercises/13-variadic-max.asm", [
        (r"-> wait n=3.*", ""),
        (r"wait n=3", ""),
    ]),
]

def apply_header_fixes():
    for rel, subs in HEADER_FIXES:
        p = Path("/workspace") / rel
        if not p.is_file():
            continue
        t = p.read_text(encoding="utf-8")
        for pat, rep in subs:
            t = re.sub(pat, rep, t, flags=re.I)
        p.write_text(t, encoding="utf-8")

def inject_helper_tasks():
    for name, task in HELPER_TASKS.items():
        p = ROOT / "04-stack-calling-convention" / "exercises" / name
        if not p.is_file():
            p = ROOT / "05-procedures-recursion" / "exercises" / name
        if not p.is_file():
            continue
        t = p.read_text(encoding="utf-8")
        if task in t:
            continue
        t = re.sub(
            r"(; Expected exit:.*\n);",
            rf"\1;\n; {task}\n;",
            t,
            count=1,
        )
        p.write_text(t, encoding="utf-8")

def expand_l10_l18():
    for i in range(10, 19):
        lesson_dirs = list(ROOT.glob(f"{i:02d}-*/exercises"))
        for exdir in lesson_dirs:
            for p in exdir.glob("*.asm"):
                sol = p.parent.parent / "solutions" / p.name
                if not sol.is_file():
                    continue
                st = sol.read_text(encoding="utf-8")
                desc = []
                for line in st.splitlines()[1:10]:
                    if line.startswith(";") and "Build" not in line and "Expected exit" not in line:
                        s = line[1:].strip()
                        if s and not s.startswith("Exercise "):
                            desc.append(s)
                if not desc:
                    continue
                et = p.read_text(encoding="utf-8")
                # skip if already has multi-line task (more than 2 desc lines in header)
                header = et.split(".CODE")[0].split(".DATA")[0]
                if len([l for l in header.splitlines() if l.startswith(";") and "Contract" not in l and "Expected" not in l]) > 5:
                    continue
                block = "\n".join(f"; {d}" for d in desc[:3])
                if block in et:
                    continue
                et2 = re.sub(
                    r"(; Exercise:.*?\n);\n",
                    rf"\1;\n{block}\n;\n",
                    et,
                    count=1,
                )
                if et2 != et:
                    p.write_text(et2, encoding="utf-8")

def fix_l08_21_dup():
    p = ROOT / "08-syscalls-files-mmap/exercises/21-debug-fd-leak-pattern.asm"
    t = p.read_text(encoding="utf-8")
    lines = t.splitlines()
    seen = False
    out = []
    for line in lines:
        if re.match(r";\s*Expected exit:", line, re.I):
            if seen:
                continue
            seen = True
        out.append(line)
    p.write_text("\n".join(out) + "\n", encoding="utf-8")

def main():
    externdef_all()
    strip_debug_dead()
    apply_header_fixes()
    inject_helper_tasks()
    expand_l10_l18()
    fix_l08_21_dup()
    print("done")

if __name__ == "__main__":
    main()
