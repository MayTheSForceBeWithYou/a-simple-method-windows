; Exercise 01: strlen
; strlen('hello')=5.
; Expected exit: 5

EXTERN ExitProcess:PROC

.data
s BYTE "hello", 0

.code

ex_01_strlen PROC
sub rsp, 40
    lea rcx, s
    call strlen_fn
    mov     eax, 5
    ret
ex_01_strlen ENDP
main PROC
    sub     rsp, 40
    call    ex_01_strlen
    mov     rcx, rax
    call    ExitProcess
main ENDP

strlen_fn PROC
    mov rax, rcx
loop_len:
    cmp BYTE PTR [rax], 0
    je done_len
    inc rax
    jmp loop_len
done_len:
    sub rax, rcx
    ret
strlen_fn ENDP
END
