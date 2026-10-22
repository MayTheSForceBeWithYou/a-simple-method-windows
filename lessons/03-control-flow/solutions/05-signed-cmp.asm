; Exercise 05: signed cmp (Win32 port) - SOLUTION
; Expected exit: 1

.CODE

EXTRN ExitProcess:PROC

ex_05_signed_cmp PROC
mov rax, -5
    mov rbx, 3
    cmp rax, rbx
    jl less_than
    xor ecx, ecx
    jmp done
less_than:
    mov rcx, 1
done:
    ret
ex_05_signed_cmp ENDP
main PROC
    sub     rsp, 40
    call    ex_05_signed_cmp
    mov     rcx, rax
    call    ExitProcess
main ENDP

END
