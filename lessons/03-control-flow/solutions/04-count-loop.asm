; Exercise: 04-count-loop
;
; Expected exit: 5
;
.CODE

EXTRN ExitProcess:PROC
ex_04_count_loop PROC
    sub rsp, 40
    
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
    mov     eax, eax
    add     rsp, 40
    ret
ex_04_count_loop ENDP
main PROC
    sub     rsp, 40
    call    ex_04_count_loop
    mov     rcx, rax
    call    ExitProcess
main ENDP

END
