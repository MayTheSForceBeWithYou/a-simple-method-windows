; Expected exit: 12

EXTERN ExitProcess:PROC

.code

ex_07_extract_bitfield PROC
mov rax, 0ABCDh
    shr rax, 4
    and rax, 0Fh
    mov rcx, rax
    ret
ex_07_extract_bitfield ENDP
main PROC
    sub     rsp, 40
    call    ex_07_extract_bitfield
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
