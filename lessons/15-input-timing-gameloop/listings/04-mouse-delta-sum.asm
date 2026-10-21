; Listing 04: Manhattan sum of mouse deltas (LESSON.md block 4)
; Expected exit: 7
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    mov     rax, 5
    mov     rbx, -2
    test    rbx, rbx
    jns     pos
    neg     rbx
pos:
    add     rax, rbx
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
