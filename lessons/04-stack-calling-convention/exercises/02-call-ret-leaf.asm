; Exercise: 02-call-ret-leaf
;
; Write leaf answer that returns 42 in rax. call it; exit with that.
;
; Contract: implement `ex_02_call_ret_leaf` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_02_call_ret_leaf:PROC

; TODO: write ex_02_call_ret_leaf in this file.

main PROC
    sub     rsp, 40
    call    ex_02_call_ret_leaf
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
