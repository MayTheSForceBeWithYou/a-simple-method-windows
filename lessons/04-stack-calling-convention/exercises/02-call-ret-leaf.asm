; Exercise: 02-call-ret-leaf
;
; Write leaf answer that returns 42 in rax. call it; exit with that.
;
; Contract: implement `ex_02_call_ret_leaf` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;
; Implement leaf `answer` returning 42 in RAX. In `ex_02_call_ret_leaf`, call `answer` and return that value as the process exit code.
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_02_call_ret_leaf:PROC

; TODO: write ex_02_call_ret_leaf in this file.

main PROC
    sub     rsp, 40
    call    ex_02_call_ret_leaf
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
