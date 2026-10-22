; Expected exit: 85

EXTERN ExitProcess:PROC

.code
ex_15_bitfield_pack PROC
    sub rsp, 40
    mov rax, 5
    and rax, 7
    mov rbx, 2
    and rbx, 7
    shl rbx, 3
    or rax, rbx
    mov rbx, 1
    and rbx, 3
    shl rbx, 6
    or rax, rbx
    mov rcx, rax
        mov     eax, 60
    add     rsp, 40
    ret
ex_15_bitfield_pack ENDP
main PROC
    sub     rsp, 40
    call    ex_15_bitfield_pack
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
