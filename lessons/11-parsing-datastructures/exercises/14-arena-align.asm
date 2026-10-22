; 14-arena-align
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_14_arena_align:PROC
main PROC
    ; TODO: write ex_14_arena_align in this file.
    call    ex_14_arena_align
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
