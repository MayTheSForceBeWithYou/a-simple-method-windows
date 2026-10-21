; Listing 10: Single fixed step from microseconds (LESSON.md block 10)
; Expected exit: 1
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
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
