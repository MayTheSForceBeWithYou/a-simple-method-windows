; 11-mouse-delta: mouse delta
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_11_mouse_delta:PROC
main PROC
    ; TODO: write ex_11_mouse_delta in this file.
    call    ex_11_mouse_delta
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
