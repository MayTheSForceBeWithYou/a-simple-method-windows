; Listing 10: Two-axis Manhattan |dx|+|dy|
; Expected exit: 10
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    push    rbx
    sub     rsp, 32
    mov     rax, 10
    mov     rbx, 5
    sub     rax, rbx
    call    abs_rax
    mov     rbx, rax
    mov     rax, 3
    mov     rcx, 8
    sub     rax, rcx
    call    abs_rax
    add     rbx, rax
    mov     ecx, ebx
    call    ExitProcess
main ENDP

abs_rax PROC
    test    rax, rax
    jns     abs_done
    neg     rax
abs_done:
    ret
abs_rax ENDP

END
