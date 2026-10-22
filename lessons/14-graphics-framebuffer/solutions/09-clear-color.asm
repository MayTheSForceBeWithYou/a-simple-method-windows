; Exercise: 09-clear-color
;
; Clear 4 pixels to color 5; exit first.
; Expected stdout: (none)
; Expected exit: 5
;
.data?
fb BYTE 4 DUP(?)

.code
ex_09_clear_color PROC
    sub rsp, 40
    mov al, 5
    lea rdi, fb
    mov rcx, 4
    rep stosb
    movzx rcx, BYTE PTR [fb]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_09_clear_color ENDP
main PROC
    sub     rsp, 40
    call    ex_09_clear_color
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
