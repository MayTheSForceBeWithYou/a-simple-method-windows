; Exercise 04: count loop (Win32 port) - SOLUTION

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    xor rcx, rcx
    xor rax, rax
loop_start:
    cmp rcx, 5
    jge loop_done
    inc rax
    inc rcx
    jmp loop_start
loop_done:
    mov rcx, rax
    call ExitProcess
main ENDP

END
