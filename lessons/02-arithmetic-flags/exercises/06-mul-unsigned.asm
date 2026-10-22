; Exercise: 06-mul-unsigned
;
; rax=100000, rbx=3; mul rbx; exit with low 8 bits of rax. Product 300000, status 300000&255=224.
;
; Contract: implement `ex_06_mul_unsigned` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 224
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_06_mul_unsigned:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_06_mul_unsigned in this file.
    call    ex_06_mul_unsigned
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
