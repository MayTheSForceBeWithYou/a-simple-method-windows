; Exercise: 02-exit-seven
;
; Exit with status 7.
;
; Contract: implement `ex_02_exit_seven` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 7
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_02_exit_seven:PROC

main PROC
    sub     rsp, 40                ; Shadow space required by ABI
    
    ; TODO: Set up exit code 7 in RCX and call ExitProcess
    ; TODO: write ex_02_exit_seven in this file.
    call    ex_02_exit_seven
    mov     ecx, eax
    call    ExitProcess

main ENDP

END
