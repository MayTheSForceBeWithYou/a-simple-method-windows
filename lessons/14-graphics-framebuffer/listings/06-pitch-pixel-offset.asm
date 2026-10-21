; Listing 06: y*pitch + x*bpp pixel offset
; Expected exit: 40
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     rax, 1
    mov     rbx, 32
    imul    rax, rbx
    mov     rbx, 2
    shl     rbx, 2
    add     rax, rbx
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
