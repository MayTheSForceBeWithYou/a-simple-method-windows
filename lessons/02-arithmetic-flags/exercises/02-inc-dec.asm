; Exercise: 02-inc-dec
;
; rax=5; inc; inc; dec; mov rcx,rax; exit (6).
;
; Contract: implement `ex_02_inc_dec` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 6
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_02_inc_dec:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_02_inc_dec in this file.
    call    ex_02_inc_dec
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
