; Exercise 15: rec strlen
; Recursive strlen("abcd")=4.
; Expected exit: 4

EXTERN ExitProcess:PROC

.data
s BYTE "abcd", 0

.code
ex_15_rec_strlen PROC
    sub rsp, 40
    lea rcx, s
    call rstrlen
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_15_rec_strlen ENDP
main PROC
    sub     rsp, 40
    call    ex_15_rec_strlen
    mov     rcx, rax
    call    ExitProcess
main ENDP

rstrlen PROC
    cmp BYTE PTR [rcx], 0
    je zero_len
    inc rcx
    sub rsp, 40
    call rstrlen
    add rsp, 40
    inc rax
    ret
zero_len:
    xor rax, rax
    ret
rstrlen ENDP
END
