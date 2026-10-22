; 14-blit-key: blit key
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_14_blit_key:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_14_blit_key in this file.
    call    ex_14_blit_key
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
