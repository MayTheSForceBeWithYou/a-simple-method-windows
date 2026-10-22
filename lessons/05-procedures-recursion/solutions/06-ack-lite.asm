; Exercise: 06-ack-lite
;
; ack(1,1) = 3. MS x64 ABI.
; Expected exit: 3
;
.code
ex_06_ack_lite PROC
    sub rsp, 40
    mov rcx, 1
    mov rdx, 1
    call ack
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_06_ack_lite ENDP
main PROC
    sub     rsp, 40
    call    ex_06_ack_lite
    mov     rcx, rax
    call    ExitProcess
main ENDP

ack PROC
    cmp rcx, 0
    je m_zero
    cmp rdx, 0
    je n_zero
    push rcx
    sub rsp, 40
    dec rdx
    call ack
    add rsp, 40
    mov rdx, rax
    pop rcx
    dec rcx
    jmp ack
m_zero:
    mov rax, rdx
    inc rax
    ret
n_zero:
    dec rcx
    mov rdx, 1
    jmp ack
ack ENDP
END
