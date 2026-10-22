; Exercise 03: sum loop (Win32 port) - SOLUTION
; Expected exit: 55

.CODE

EXTRN ExitProcess:PROC
ex_03_sum_loop PROC
    sub rsp, 40
    
    xor rax, rax
    mov rcx, 10
loop_start:
    cmp rcx, 0
    jle loop_done
    add rax, rcx
    dec rcx
    jmp loop_start
loop_done:
        mov     eax, rax
    ret
    add     rsp, 40
ex_03_sum_loop ENDP
main PROC
    call    ex_03_sum_loop
    mov     rcx, rax
    call    ExitProcess
main ENDP

END
