; Exercise: 17-precedence
;
; Encode * binds tighter: 2+3*4 = 14; exit 14.
;
; Contract: implement `ex_17_precedence` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 14
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_17_precedence:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_17_precedence in this file.
    call    ex_17_precedence
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
