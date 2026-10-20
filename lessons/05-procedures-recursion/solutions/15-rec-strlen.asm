; Exercise 15: rec strlen
; Recursive strlen("abcd")=4.
; Expected exit: 4

EXTERN ExitProcess:PROC

.data
s BYTE "abcd", 0

.code
main PROC
    sub rsp, 32
    lea rcx, s
    call rstrlen
    mov rcx, rax
    call ExitProcess
main ENDP

rstrlen PROC
    cmp BYTE PTR [rcx], 0
    je zero_len
    inc rcx
    sub rsp, 32
    call rstrlen
    add rsp, 32
    inc rax
    ret
zero_len:
    xor rax, rax
    ret
rstrlen ENDP
END
