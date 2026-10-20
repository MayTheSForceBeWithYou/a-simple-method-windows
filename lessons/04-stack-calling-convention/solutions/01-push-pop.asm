; Exercise 01: push pop (Win32 port) - SOLUTION

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 42
    push rax
    mov rax, 99
    push rax
    pop rbx                    ; RBX = 99
    pop rcx                    ; RCX = 42
    call ExitProcess
    
main ENDP
END
