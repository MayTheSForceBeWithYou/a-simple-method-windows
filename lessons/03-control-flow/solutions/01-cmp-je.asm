; Exercise 01: cmp je (Win32 port) - SOLUTION
; Expected exit: 1

.CODE

EXTRN ExitProcess:PROC

main PROC
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
    call ExitProcess
main ENDP

END
