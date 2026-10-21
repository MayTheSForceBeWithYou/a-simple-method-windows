; Listing 07: Q16 lerp(0, 10, t=0.5) -> 5
; Expected exit: 5
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     eax, 0
    mov     ebx, 10
    shl     ebx, 16
    mov     ecx, 1
    shl     ecx, 15
    movsxd  rax, ebx
    movsxd  rdx, ecx
    imul    rax, rdx
    shr     rax, 16
    shr     rax, 16
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
