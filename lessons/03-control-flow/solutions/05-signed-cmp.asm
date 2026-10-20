; Exercise 05: signed cmp (Win32 port) - SOLUTION

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, -5
    mov rbx, 3
    cmp rax, rbx
    jl less_than
    xor ecx, ecx
    jmp done
less_than:
    mov rcx, 1
done:
    call ExitProcess
main ENDP

END
