; Exercise: 20-sqrt-newton-stub
;
; Integer sqrt of 9 via one Newton step from 5; exit 3.
;
; Contract: implement `ex_20_sqrt_newton_stub` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_sqrt_newton_stub:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_20_sqrt_newton_stub in this file.
    call    ex_20_sqrt_newton_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
