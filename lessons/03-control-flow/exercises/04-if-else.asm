; Exercise: 04-if-else
;
; If rax>10 exit 1 else exit 2. Set rax=11.
;
; Contract: implement `ex_04_if_else` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_04_if_else:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_04_if_else in this file.
    call    ex_04_if_else
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
