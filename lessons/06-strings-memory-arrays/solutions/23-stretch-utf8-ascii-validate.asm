; Exercise 23: stretch ascii validate
;
; STRETCH: validate all bytes <128 in "OK\n"; exit 1 if valid.
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
s BYTE "OK", 10, 0

.code
main PROC
    sub rsp, 40
    lea rdx, s
val_loop:
    movzx rax, BYTE PTR [rdx]
    test rax, rax
    jz val_ok
    test rax, 80h
    jnz val_bad
    inc rdx
    jmp val_loop
val_ok:
    mov rcx, 1
    jmp val_done
val_bad:
    xor ecx, ecx
val_done:
    call ExitProcess
main ENDP
END
