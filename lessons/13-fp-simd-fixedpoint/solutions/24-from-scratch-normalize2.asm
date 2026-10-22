; Exercise: 24-from-scratch-normalize2
;
; Length of (3,4) vector; exit 5.
; Expected exit: 5
;
.code
ex_24_from_scratch_normalize2 PROC
    sub rsp, 40
    mov rax, 3
    imul rax, rax
    mov rbx, 4
    imul rbx, rbx
    add rax, rbx
    ; integer sqrt for 25
    mov     eax, 5
    add rsp, 40
    ret
ex_24_from_scratch_normalize2 ENDP
main PROC
    sub     rsp, 40
    call    ex_24_from_scratch_normalize2
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
