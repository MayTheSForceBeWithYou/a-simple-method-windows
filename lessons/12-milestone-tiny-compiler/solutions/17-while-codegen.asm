; Exercise 17: while codegen
;
; while i<3 i++; exit i=3.
; Expected exit: 3

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    xor rcx, rcx
loop_while:
    cmp rcx, 3
    jge done_while
    inc rcx
    jmp loop_while
done_while:
    call ExitProcess
main ENDP
END
