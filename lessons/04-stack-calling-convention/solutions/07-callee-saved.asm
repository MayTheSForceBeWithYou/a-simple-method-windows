; Exercise: 07-callee-saved
;
; Caller puts 9 in rbx. Callee must preserve rbx. Exit rbx (9). (rbx is nonvolatile on Windows)
; Expected exit: 9
;
.code
ex_07_callee_saved PROC FRAME
    push rbx
    .pushreg rbx
    sub rsp, 32
    .allocstack 32
    .endprolog
    mov rbx, 9
    call clobber_careful
    mov     eax, ebx
    add rsp, 32
    pop rbx
    ret
ex_07_callee_saved ENDP
main PROC
    sub     rsp, 40
    call    ex_07_callee_saved
    mov     rcx, rax
    call    ExitProcess
main ENDP

clobber_careful PROC
    push rbx
    mov rbx, 123
    pop rbx
    ret
clobber_careful ENDP
END
