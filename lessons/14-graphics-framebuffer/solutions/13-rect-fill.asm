; Exercise: 13-rect-fill
;
; Fill 2x2 rect with 3; sum=12.
; Expected stdout: (none)
; Expected exit: 12
;
.data?
fb BYTE 16 DUP(?)

.code
ex_13_rect_fill PROC
    sub rsp, 40
    mov BYTE PTR [fb], 3
    mov BYTE PTR [fb+1], 3
    mov BYTE PTR [fb+4], 3
    mov BYTE PTR [fb+5], 3
    xor rcx, rcx
    movzx rax, BYTE PTR [fb]
    add rcx, rax
    movzx rax, BYTE PTR [fb+1]
    add rcx, rax
    movzx rax, BYTE PTR [fb+4]
    add rcx, rax
    movzx rax, BYTE PTR [fb+5]
    add rcx, rax
    mov     eax, ecx
    add     rsp, 40
    ret
ex_13_rect_fill ENDP
main PROC
    sub     rsp, 40
    call    ex_13_rect_fill
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
