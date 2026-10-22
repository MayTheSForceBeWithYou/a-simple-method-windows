; Exercise 17: while codegen
;
; while i<3 i++; exit i=3.
; Expected exit: 3

EXTERN ExitProcess:PROC

.code

ex_17_while_codegen PROC
xor rcx, rcx
loop_while:
    cmp rcx, 3
    jge done_while
    inc rcx
    jmp loop_while
done_while:
    mov     eax, 3
    ret
ex_17_while_codegen ENDP
main PROC
    sub     rsp, 40
    call    ex_17_while_codegen
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
