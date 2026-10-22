; Listing 11: Integer hash mix (LESSON.md block 11)
; Expected exit: 45
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     rax, 5
    mov     rbx, rax
    shl     rbx, 3
    xor     rax, rbx
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
