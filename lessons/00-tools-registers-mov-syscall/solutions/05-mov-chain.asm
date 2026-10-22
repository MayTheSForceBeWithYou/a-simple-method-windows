; Exercise: 05-mov-chain
;
; Set al=3, bl=5, cl=7. Sum into dil, movzx to rdi, exit (expect 15).
; Expected exit: 15
;
.code
ex_05_mov_chain PROC
    sub rsp, 40
    mov al, 3
    mov bl, 5
    mov cl, 7
    mov dil, al
    add dil, bl
    add dil, cl
    movzx rcx, dil
    mov     eax, ecx
    add     rsp, 40
    ret
ex_05_mov_chain ENDP
main PROC
    sub     rsp, 40
    call    ex_05_mov_chain
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
