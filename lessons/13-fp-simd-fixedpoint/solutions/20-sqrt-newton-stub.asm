; Exercise: 20-sqrt-newton-stub
;
; Integer sqrt of 9 via one Newton step from 5; exit 3.
; Expected exit: 3
;
.code
ex_20_sqrt_newton_stub PROC
    sub rsp, 40
    mov rax, 9
    mov rbx, 5
    mov rcx, rax
    xor rdx, rdx
    div rbx
    add rbx, rax
    shr rbx, 1
    mov     eax, ebx
    add rsp, 40
    ret
ex_20_sqrt_newton_stub ENDP
main PROC
    sub     rsp, 40
    call    ex_20_sqrt_newton_stub
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
