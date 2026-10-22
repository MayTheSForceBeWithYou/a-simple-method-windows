; Exercise: 17-while-codegen
;
; while i<3 i++; exit i=3.
; Expected exit: 3
;
.code
ex_17_while_codegen PROC
    sub rsp, 40
    xor rcx, rcx
loop_while:
    cmp rcx, 3
    jge done_while
    inc rcx
    jmp loop_while
done_while:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_17_while_codegen ENDP
main PROC
    sub     rsp, 40
    call    ex_17_while_codegen
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
