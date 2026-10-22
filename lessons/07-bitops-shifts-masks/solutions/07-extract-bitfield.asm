; Expected exit: 12

EXTERN ExitProcess:PROC

.code
ex_07_extract_bitfield PROC
    sub rsp, 40
    mov rax, 0ABCDh
    shr rax, 4
    and rax, 0Fh
    call ExitProcess
    add     rsp, 40
    ret
ex_07_extract_bitfield ENDP
main PROC
    sub     rsp, 40
    call    ex_07_extract_bitfield
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
