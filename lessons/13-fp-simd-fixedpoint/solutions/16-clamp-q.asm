; Exercise 16: clamp q
;
; Clamp -3 to [0,100]; exit 0.
; Expected exit: 0

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rax, -3
    cmp rax, 0
    jge clamp_hi
    xor rax, rax
clamp_hi:
    cmp rax, 100
    jle clamp_ok
    mov rax, 100
clamp_ok:
    mov rcx, rax
    call ExitProcess
main ENDP
END
