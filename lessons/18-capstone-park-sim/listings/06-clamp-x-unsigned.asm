; Listing 06: Unsigned clamp x to [0, width) (LESSON.md block 6)
; Expected exit: 7
; Expected stdout: (none)

width EQU 8

.CODE
EXTRN ExitProcess:PROC

main PROC
    mov     rax, 99
    cmp     rax, width
    jb      ok
    mov     rax, width
    dec     rax
ok:
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
