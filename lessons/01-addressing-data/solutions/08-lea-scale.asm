; Exercise: 08-lea-scale
;
; Without memory load: rbx=100, r8=3. lea rcx,[rbx+r8*4] (112), exit.
; Expected exit: 112
;
.code
ex_08_lea_scale PROC
    sub rsp, 40
    mov rbx, 100
    mov r8, 3
    lea rcx, [rbx+r8*4]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_08_lea_scale ENDP
main PROC
    sub     rsp, 40
    call    ex_08_lea_scale
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
