; Listing 02: Tile (tx,ty) to linear index
; Expected exit: 53
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub     rsp, 32
    mov     rax, 3
    mov     rbx, 16
    imul    rax, rbx
    add     rax, 5
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
