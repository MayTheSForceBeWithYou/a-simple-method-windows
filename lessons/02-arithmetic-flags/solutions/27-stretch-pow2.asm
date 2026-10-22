; Exercise: 27-stretch-pow2
;
; STRETCH: compute 2^8 with successive imuls. Exit (256 - 256)=0.
; Expected exit: 0
;
.code
ex_27_stretch_pow2 PROC
    sub rsp, 40
    mov rax, 1
    imul rax, 2
    imul rax, 2
    imul rax, 2
    imul rax, 2
    imul rax, 2
    imul rax, 2
    imul rax, 2
    imul rax, 2
    sub rax, 256
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_27_stretch_pow2 ENDP
main PROC
    sub     rsp, 40
    call    ex_27_stretch_pow2
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
