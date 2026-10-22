; Exercise: 03-exit-from-register
;
; Put 42 in rbx, copy to rcx, exit with that status. Immediate only allowed when loading rbx.
;
; Contract: implement `ex_03_exit_from_register` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_03_exit_from_register:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_03_exit_from_register in this file.
    call    ex_03_exit_from_register
    mov     ecx, eax
    call    ExitProcess
    
main ENDP

END
