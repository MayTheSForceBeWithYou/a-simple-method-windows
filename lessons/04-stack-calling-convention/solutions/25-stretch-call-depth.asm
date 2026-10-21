; Exercise 25: stretch call depth
;
; STRETCH: bump(rcx) calls itself depth times adding 1 each return. bump(5) returns 5.
;
; Expected exit: 5
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
main PROC FRAME
    sub rsp, 40
    .ALLOCSTACK 40
    .ENDPROLOG
    mov rcx, 5
    call bump
    mov rcx, rax
    call ExitProcess
main ENDP

bump PROC FRAME
    push rbx
    .PUSHREG rbx
    sub rsp, 32
    .ALLOCSTACK 32
    .ENDPROLOG
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
