; 14-blit-key: blit key
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_14_blit_key:PROC
main PROC
    ; TODO: implement ex_14_blit_key (student routine; defined in solutions/).
    call    ex_14_blit_key
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
