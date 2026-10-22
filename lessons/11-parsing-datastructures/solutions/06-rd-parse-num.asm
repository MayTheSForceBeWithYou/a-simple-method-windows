; Exercise 06: rd parse num
;
; Parse '3' into value; exit 3.
; Expected exit: 3

EXTERN ExitProcess:PROC

.data
s BYTE "3", 0

.code
ex_06_rd_parse_num PROC
    sub rsp, 40
    movzx rcx, BYTE PTR [s]
    sub rcx, '0'
    mov     eax, ecx
    add     rsp, 40
    ret
ex_06_rd_parse_num ENDP
main PROC
    sub     rsp, 40
    call    ex_06_rd_parse_num
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
