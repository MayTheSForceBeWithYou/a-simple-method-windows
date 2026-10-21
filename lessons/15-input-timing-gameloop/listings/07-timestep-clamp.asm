; Listing 07: Clamp simulation steps (LESSON.md block 7)
; Expected exit: 3
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    mov     rax, 100
    xor     rdx, rdx
    mov     rbx, 16
    div     rbx
    cmp     rax, 3
    jbe     ok
    mov     rax, 3
ok:
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
