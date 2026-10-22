; Exercise: 20-dot3
;
; dot (1,2,3)*(4,5,6)=32; exit 32.
;
; Contract: implement `ex_20_dot3` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 32
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_20_dot3:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_20_dot3 in this file.
    call    ex_20_dot3
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
