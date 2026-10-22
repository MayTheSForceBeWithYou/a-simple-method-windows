; Exercise 23: stretch bit reverse 8
;
; Reverse bits of 080h -> 001h; exit 1.
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
v BYTE 80h

.code
ex_23_stretch_bit_reverse8 PROC
    sub rsp, 40
    movzx eax, BYTE PTR [v]
    xor r8d, r8d
    mov r9d, 8
rev_loop:
    shl r8d, 1
    mov edx, eax
    and edx, 1
    or r8d, edx
    shr eax, 1
    dec r9d
    jnz rev_loop
    mov ecx, r8d
    mov     eax, r8d
    add     rsp, 40
    ret
ex_23_stretch_bit_reverse8 ENDP
main PROC
    sub     rsp, 40
    call    ex_23_stretch_bit_reverse8
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
