; Listing 06: Q16.16 divide 6.0 / 2.0 with widened dividend
; Expected exit: 3
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    push    rbx
    sub     rsp, 32
    mov     eax, 6
    shl     eax, 16
    mov     ebx, 2
    shl     ebx, 16
    movsxd  rax, eax
    shl     rax, 16
    movsxd  rbx, ebx
    cqo
    idiv    rbx
    shr     rax, 16
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
