; 17-vsync-stub: vsync stub
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_17_vsync_stub:PROC
main PROC
    ; TODO: implement ex_17_vsync_stub (student routine; defined in solutions/).
    call    ex_17_vsync_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
