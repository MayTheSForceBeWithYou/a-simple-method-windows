; Exercise: 02-if-else
;
; Implement `ex_02_if_else` in this file.
;
; Contract: implement `ex_02_if_else` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 20
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_02_if_else:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_02_if_else in this file.
    call    ex_02_if_else
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
