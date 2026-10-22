; Exercise: 19-expr-eax
;
; Compute (3+5)*7-8 into rcx (48).
;
; Contract: implement `ex_19_expr_eax` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 48
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_19_expr_eax:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_19_expr_eax in this file.
    call    ex_19_expr_eax
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
