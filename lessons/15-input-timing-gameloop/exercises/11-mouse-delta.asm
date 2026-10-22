; 11-mouse-delta: mouse delta
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_11_mouse_delta:PROC
main PROC
    ; TODO: implement ex_11_mouse_delta (student routine; defined in solutions/).
    call    ex_11_mouse_delta
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
