; 04-arena-bump
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_04_arena_bump:PROC
main PROC
    ; TODO: implement ex_04_arena_bump (student routine; defined in solutions/).
    call    ex_04_arena_bump
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
