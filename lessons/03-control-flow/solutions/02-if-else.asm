; Exercise 02: if else (Win32 port) - SOLUTION
; Expected exit: 20

.CODE

EXTRN ExitProcess:PROC

ex_02_if_else PROC
mov rax, 5
    cmp rax, 10
    jge else_branch
    mov rcx, 20
    jmp done
else_branch:
    mov rcx, 30
done:

    ret
ex_02_if_else ENDP
main PROC
    sub     rsp, 40
    call    ex_02_if_else
    mov     rcx, rax
    call    ExitProcess
main ENDP

END
