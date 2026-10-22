; 14-arena-align
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_14_arena_align:PROC
main PROC
    ; TODO: implement ex_14_arena_align (student routine; defined in solutions/).
    call    ex_14_arena_align
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
