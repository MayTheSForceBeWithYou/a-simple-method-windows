; Listing 06: Unsigned clamp x to [0, width) (LESSON.md block 6)
; Expected exit: 7
; Expected stdout: (none)

grid_w EQU 8

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     rax, 99
    cmp     rax, grid_w
    jb      ok
    mov     rax, grid_w
    dec     rax
ok:
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
