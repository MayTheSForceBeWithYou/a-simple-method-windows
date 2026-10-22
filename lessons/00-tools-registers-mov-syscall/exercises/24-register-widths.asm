; Exercise: 24-register-widths
;
; rax=01111222233334444h; mov ax,0ABCDh; exit with movzx rcx,al (205).
;
; Contract: implement `ex_24_register_widths` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 205
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_24_register_widths:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_24_register_widths in this file.
    call    ex_24_register_widths
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
