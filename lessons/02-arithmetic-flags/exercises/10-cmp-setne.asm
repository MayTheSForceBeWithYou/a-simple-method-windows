; Exercise: 10-cmp-setne
;
; rax=5, rbx=6. setne -> exit 1.
;
; Contract: implement `ex_10_cmp_setne` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_10_cmp_setne:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_10_cmp_setne in this file.
    call    ex_10_cmp_setne
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
