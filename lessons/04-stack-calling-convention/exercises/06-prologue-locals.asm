; Exercise: 06-prologue-locals
;
; Function stores local = rcx+1 on stack frame; returns it. Call with 41; exit 42.
;
; Contract: implement `ex_06_prologue_locals` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;
; Implement `sum_locals(rcx)` with three QWORD locals summing rcx+1..rcx+3. In `ex_06_prologue_locals`, call with 10 and exit 33.
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_06_prologue_locals:PROC

; TODO: write ex_06_prologue_locals in this file.

main PROC
    sub     rsp, 40
    call    ex_06_prologue_locals
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
