; 04-ui-hit: ui hit
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_04_ui_hit:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_04_ui_hit in this file.
    call    ex_04_ui_hit
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
