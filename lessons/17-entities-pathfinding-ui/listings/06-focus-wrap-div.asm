; Listing 06: Focus index wrap with div (LESSON.md block 6)
; Expected exit: 0
; Expected stdout: (none)

.DATA?
focus QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     focus, 2
    inc     focus
    mov     rax, focus
    xor     rdx, rdx
    mov     rbx, 3
    div     rbx
    mov     ecx, edx
    call    ExitProcess
main ENDP
END
