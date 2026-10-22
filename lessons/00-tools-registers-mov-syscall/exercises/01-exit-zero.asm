; Exercise: 01-exit-zero
;
; Exit with status 0 using ExitProcess.
;
; Contract: implement `ex_01_exit_zero` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_01_exit_zero:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_01_exit_zero in this file.
    call    ex_01_exit_zero
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
