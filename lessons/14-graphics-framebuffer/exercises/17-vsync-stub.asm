; 17-vsync-stub: vsync stub
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_17_vsync_stub:PROC
main PROC
    ; TODO: write ex_17_vsync_stub in this file.
    call    ex_17_vsync_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
