; Exercise: 07-rep-movsb
;
; Copy 5 bytes [1..5]; sum=15.
; Expected exit: 15
;
.data
src BYTE 1,2,3,4,5

.data?
dst BYTE 5 DUP(?)

.code
ex_07_rep_movsb PROC
    sub rsp, 40
    lea rsi, src
    lea rdi, dst
    mov rcx, 5
    rep movsb
    xor rcx, rcx
    movzx rax, BYTE PTR dst[0]
    add rcx, rax
    movzx rax, BYTE PTR dst[1]
    add rcx, rax
    movzx rax, BYTE PTR dst[2]
    add rcx, rax
    movzx rax, BYTE PTR dst[3]
    add rcx, rax
    movzx rax, BYTE PTR dst[4]
    add rcx, rax
    mov     eax, ecx
    add     rsp, 40
    ret
ex_07_rep_movsb ENDP
main PROC
    sub     rsp, 40
    call    ex_07_rep_movsb
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
