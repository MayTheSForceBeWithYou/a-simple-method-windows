; Exercise: 26-stretch-atoi
;
; STRETCH: parse "42" decimal ascii into rcx (42) with a loop.
; Expected exit: 42
;
.data
s BYTE "42", 0

.code
ex_26_stretch_atoi PROC
    sub rsp, 40
    lea rsi, [s]
    xor rcx, rcx
loop_start:
    movzx rax, BYTE PTR [rsi]
    test rax, rax
    jz done
    sub rax, '0'
    imul rcx, 10
    add rcx, rax
    inc rsi
    jmp loop_start
done:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_26_stretch_atoi ENDP
main PROC
    sub     rsp, 40
    call    ex_26_stretch_atoi
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
