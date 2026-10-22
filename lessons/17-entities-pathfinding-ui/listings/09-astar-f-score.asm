; Listing 09: A* score f = g + h
; Expected exit: 7
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    push    rbx
    sub     rsp, 32
    mov     rax, 3
    mov     rbx, 1
    sub     rax, rbx
    call    abs_rax
    mov     rbx, rax
    mov     rax, 4
    mov     rcx, 2
    sub     rax, rcx
    call    abs_rax
    add     rbx, rax
    mov     rax, 3
    add     rax, rbx
    mov     ecx, eax
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
