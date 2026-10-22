; Exercise: 18-strlen-loop
;
; Cstring 'hello',0. Count length 5 into rcx.
; Expected exit: 5
;
.data
s BYTE "hello", 0

.code
ex_18_strlen_loop PROC
    sub rsp, 40
    lea rsi, [s]
    xor rcx, rcx
loop_start:
    cmp BYTE PTR [rsi], 0
    je done
    inc rcx
    inc rsi
    jmp loop_start
done:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_18_strlen_loop ENDP
main PROC
    sub     rsp, 40
    call    ex_18_strlen_loop
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
