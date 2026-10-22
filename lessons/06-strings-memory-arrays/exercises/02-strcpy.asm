; Exercise: 02-strcpy
;
; Copy 'yo' to bss; exit length=2.
;
; Contract: implement `ex_02_strcpy` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_02_strcpy:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_02_strcpy in this file.
    call    ex_02_strcpy
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
