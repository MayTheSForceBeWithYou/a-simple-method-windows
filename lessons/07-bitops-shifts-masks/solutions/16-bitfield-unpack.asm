; Expected exit: 2

EXTERN ExitProcess:PROC

.code

ex_16_bitfield_unpack PROC
mov rax, 01010101b
    shr rax, 3
    and rax, 7
    mov rcx, rax
    mov rax,60
    ret
ex_16_bitfield_unpack ENDP
main PROC
    sub     rsp, 40
    call    ex_16_bitfield_unpack
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
