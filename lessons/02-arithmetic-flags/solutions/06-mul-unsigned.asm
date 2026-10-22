; Exercise 06: mul unsigned
;
; rax=100000, rbx=3; mul rbx; exit with low 8 bits of rax. Product 300000, status 300000&255=224.
;
; Build: ml64 /c 06-mul-unsigned.asm && link /OUT:06-mul-unsigned.exe /ENTRY:main /SUBSYSTEM:CONSOLE 06-mul-unsigned.obj kernel32.lib
;
; Expected exit: 224

EXTERN ExitProcess:PROC

.code
ex_06_mul_unsigned PROC
    sub rsp, 40
    mov rax, 100000
    mov rbx, 3
    mul rbx
    mov rcx, rax
    and rcx, 255
    mov     eax, 224
    add     rsp, 40
    ret
ex_06_mul_unsigned ENDP
main PROC
    sub     rsp, 40
    call    ex_06_mul_unsigned
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
