; Exercise 01: cmp je (Win32 port) - SOLUTION
; Expected exit: 1

.CODE

EXTRN ExitProcess:PROC

ex_01_cmp_je PROC
mov rax, 10
    mov rbx, 10
    cmp rax, rbx
    je equal
    xor ecx, ecx
    jmp done
equal:
    mov rcx, 1
done:
    ret
ex_01_cmp_je ENDP
main PROC
    sub     rsp, 40
    call    ex_01_cmp_je
    mov     rcx, rax
    call    ExitProcess
main ENDP

END
