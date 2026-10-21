; Exercise 02: if else (Win32 port) - SOLUTION
; Expected exit: 20

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 5
    cmp rax, 10
    jge else_branch
    mov rcx, 20
    jmp done
else_branch:
    mov rcx, 30
done:
    call ExitProcess
main ENDP

END
