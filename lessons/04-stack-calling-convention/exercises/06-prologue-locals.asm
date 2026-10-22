; Exercise: 06-prologue-locals
;
; Function stores local = rcx+1 on stack frame; returns it. Call with 41; exit 42.
;
; Contract: implement `ex_06_prologue_locals` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_06_prologue_locals:PROC

; TODO: write ex_06_prologue_locals in this file.

main PROC
    sub     rsp, 40
    call    ex_06_prologue_locals
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
