; 04-arena-bump
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_04_arena_bump:PROC
main PROC
    ; TODO: write ex_04_arena_bump in this file.
    call    ex_04_arena_bump
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
