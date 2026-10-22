; 05-blit-copy: blit copy
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_05_blit_copy:PROC
main PROC
    ; TODO: implement ex_05_blit_copy (student routine; defined in solutions/).
    call    ex_05_blit_copy
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
