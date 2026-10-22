; Exercise: 25-stretch-call-depth
;
; STRETCH: bump(rcx) calls itself depth times adding 1 each return. bump(5) returns 5.
; Expected stdout: (none)
; Expected exit: 5
;
.code
ex_25_stretch_call_depth PROC FRAME
    sub rsp, 40
    .ALLOCSTACK 40
    .ENDPROLOG
    mov rcx, 5
    call bump
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_25_stretch_call_depth ENDP
main PROC
    sub     rsp, 40
    call    ex_25_stretch_call_depth
    mov     rcx, rax
    call    ExitProcess
main ENDP

bump PROC FRAME
    push rbx
    .pushreg rbx
    sub rsp, 32
    .allocstack 32
    .endprolog
    mov rbx, rcx
    cmp rcx, 0
    je bump_zero
    dec rcx
    call bump
    inc rax
    jmp bump_done
bump_zero:
    xor rax, rax
bump_done:
    add rsp, 32
    pop rbx
    ret
bump ENDP
END
