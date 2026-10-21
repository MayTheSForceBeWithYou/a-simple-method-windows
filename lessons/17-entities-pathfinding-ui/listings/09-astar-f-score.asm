; Listing 09: A* score f = g + h
; Expected exit: 7
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     rax, 3
    mov     rbx, 1
    sub     rax, rbx
    call    abs_rax
    mov     rcx, rax
    mov     rax, 4
    mov     rbx, 2
    sub     rax, rbx
    call    abs_rax
    add     rcx, rax
    mov     rax, 3
    add     rax, rcx
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
