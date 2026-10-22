; Exercise: 07-idiv-setup
;
; Divide 84 by 2 using idiv. cqo; idiv. Exit with quotient in rcx.
;
; Contract: implement `ex_07_idiv_setup` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_07_idiv_setup:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_07_idiv_setup in this file.
    call    ex_07_idiv_setup
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
