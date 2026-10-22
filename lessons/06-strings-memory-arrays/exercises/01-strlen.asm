; Exercise: 01-strlen
;
; strlen('hello')=5.
;
; Contract: implement `ex_01_strlen` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 5
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_01_strlen:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_01_strlen in this file.
    call    ex_01_strlen
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
