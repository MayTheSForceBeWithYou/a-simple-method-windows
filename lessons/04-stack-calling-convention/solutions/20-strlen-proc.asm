; Exercise: 20-strlen-proc
;
; strlen('assembly')=8. MS x64 ABI.
; Expected exit: 8
;
.data
s BYTE "assembly", 0

.code
ex_20_strlen_proc PROC
    sub rsp, 40
    lea rcx, s
    call strlen_fn
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_20_strlen_proc ENDP
main PROC
    sub     rsp, 40
    call    ex_20_strlen_proc
    mov     rcx, rax
    call    ExitProcess
main ENDP

strlen_fn PROC
    mov rax, rcx
loop_start:
    cmp BYTE PTR [rax], 0
    je loop_done
    inc rax
    jmp loop_start
loop_done:
    sub rax, rcx
    ret
strlen_fn ENDP
END
