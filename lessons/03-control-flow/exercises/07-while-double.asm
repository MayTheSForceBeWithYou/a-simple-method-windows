; Exercise: 07-while-double
;
; rax=1; while rax<100 rax*=2; exit with final rax clamped: put rax in rcx then and 255; 128&255=128.
;
; Contract: implement `ex_07_while_double` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 128
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_07_while_double:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_07_while_double in this file.
    call    ex_07_while_double
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
