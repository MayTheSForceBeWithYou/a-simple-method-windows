; Listing 07: Clamp happiness after bonus (LESSON.md block 7)
; Expected exit: 100
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub     rsp, 32
    mov     rax, 90
    add     rax, 20
    cmp     rax, 100
    jle     ok
    mov     rax, 100
ok:
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
