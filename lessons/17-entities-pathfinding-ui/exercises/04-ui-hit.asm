; 04-ui-hit: ui hit
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_04_ui_hit:PROC
main PROC
    ; TODO: implement ex_04_ui_hit (student routine; defined in solutions/).
    call    ex_04_ui_hit
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
