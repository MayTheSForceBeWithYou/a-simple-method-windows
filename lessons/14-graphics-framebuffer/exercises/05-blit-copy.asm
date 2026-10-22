; 05-blit-copy: blit copy
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_05_blit_copy:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_05_blit_copy in this file.
    call    ex_05_blit_copy
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
