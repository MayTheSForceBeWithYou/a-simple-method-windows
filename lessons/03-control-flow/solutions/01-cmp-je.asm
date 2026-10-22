; Exercise 01: cmp je (Win32 port) - SOLUTION
; Expected exit: 1

.CODE

EXTRN ExitProcess:PROC
ex_01_cmp_je PROC
    sub rsp, 40
    
    mov rax, 10
    mov rbx, 10
    cmp rax, rbx
    je equal
    xor ecx, ecx
    jmp done
equal:
    mov rcx, 1
done:
    mov     eax, 1
    add     rsp, 40
    ret
ex_01_cmp_je ENDP
main PROC
    call    ex_01_cmp_je
    mov     rcx, rax
    call    ExitProcess
main ENDP

END
