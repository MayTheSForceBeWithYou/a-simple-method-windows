; Listing 08: Microseconds to fixed steps (LESSON.md block 8)
; Expected exit: 1
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    mov     rax, 16000
    xor     rdx, rdx
    mov     rbx, 1000
    div     rbx
    xor     rdx, rdx
    mov     rbx, 16
    div     rbx
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
