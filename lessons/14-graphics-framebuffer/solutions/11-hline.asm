; Exercise: 11-hline
;
; Horizontal line y=0 x=0..2 set 1; sum first 3=3.
; Expected stdout: (none)
; Expected exit: 3
;
.data?
fb BYTE 8 DUP(?)

.code
ex_11_hline PROC
    sub rsp, 40
    mov BYTE PTR [fb], 1
    mov BYTE PTR [fb+1], 1
    mov BYTE PTR [fb+2], 1
    xor rcx, rcx
    movzx rax, BYTE PTR [fb]
    add rcx, rax
    movzx rax, BYTE PTR [fb+1]
    add rcx, rax
    movzx rax, BYTE PTR [fb+2]
    add rcx, rax
    mov     eax, ecx
    add     rsp, 40
    ret
ex_11_hline ENDP
main PROC
    sub     rsp, 40
    call    ex_11_hline
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
