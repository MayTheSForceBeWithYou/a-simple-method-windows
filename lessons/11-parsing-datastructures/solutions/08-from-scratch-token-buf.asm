; Exercise 08: from scratch token buf
;
; FROM SCRATCH: store ascii 'x' as token lexeme len 1; exit 1.
; Expected exit: 1

EXTERN ExitProcess:PROC

.data?
lex BYTE 8 DUP(?)
n QWORD ?

.code

ex_08_from_scratch_token_buf PROC
sub rsp, 40
    mov BYTE PTR [lex], 'x'
    mov QWORD PTR [n], 1
    mov     eax, 1
    ret
ex_08_from_scratch_token_buf ENDP
main PROC
    sub     rsp, 40
    call    ex_08_from_scratch_token_buf
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
