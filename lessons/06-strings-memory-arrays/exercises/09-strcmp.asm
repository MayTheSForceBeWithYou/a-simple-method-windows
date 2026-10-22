; Exercise: 09-strcmp
;
; strcmp "abc","abd" -> 1.
;
; Contract: implement `ex_09_strcmp` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_09_strcmp:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_09_strcmp in this file.
    call    ex_09_strcmp
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
