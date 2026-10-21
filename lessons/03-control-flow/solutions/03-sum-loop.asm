; Exercise 03: sum loop (Win32 port) - SOLUTION
; Expected exit: 55

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    xor rax, rax
    mov rcx, 10
loop_start:
    cmp rcx, 0
    jle loop_done
    add rax, rcx
    dec rcx
    jmp loop_start
loop_done:
    mov rcx, rax
    call ExitProcess
main ENDP

END
