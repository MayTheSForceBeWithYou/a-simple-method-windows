; Exercise: 11-ll-push-front
;
; Push two nodes; head val=2; exit 2.
;
; Contract: implement `ex_11_ll_push_front` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_11_ll_push_front:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_11_ll_push_front in this file.
    call    ex_11_ll_push_front
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
