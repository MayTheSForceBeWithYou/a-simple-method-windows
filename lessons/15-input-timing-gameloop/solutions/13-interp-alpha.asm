; Exercise: 13-interp-alpha
;
; alpha = accum/step with accum=8 step=16 -> 0.5 as Q16 08000h>>15 =1? Use alpha in 0..100 =50; exit 50.
; Expected stdout: (none)
; Expected exit: 50
;
.code
ex_13_interp_alpha PROC
    sub rsp, 40
    mov rax, 8
    imul rax, 100
    xor rdx, rdx
    mov rbx, 16
    div rbx
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_13_interp_alpha ENDP
main PROC
    sub     rsp, 40
    call    ex_13_interp_alpha
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
