; Exercise: 16-expr-stack
;
; Shunting: push 2,3, add -> 5; exit 5.
;
; Contract: implement `ex_16_expr_stack` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 5
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_16_expr_stack:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_16_expr_stack in this file.
    call    ex_16_expr_stack
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
