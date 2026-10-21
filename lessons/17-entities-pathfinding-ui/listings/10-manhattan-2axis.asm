; Listing 10: Two-axis Manhattan |dx|+|dy|
; Expected exit: 10
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     rax, 10
    mov     rbx, 5
    sub     rax, rbx
    call    abs_rax
    mov     rcx, rax
    mov     rax, 3
    mov     rbx, 8
    sub     rax, rbx
    call    abs_rax
    add     rcx, rax
    mov     ecx, ecx
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
