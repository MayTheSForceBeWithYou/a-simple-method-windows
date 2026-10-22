; Listing 21: Round bump pointer up to 8-byte alignment
; Expected exit: 8
; Expected stdout: (none)

.DATA?
bump QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     bump, 1
    mov     rax, bump
    add     rax, 7
    and     rax, NOT 7
    mov     bump, rax
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
