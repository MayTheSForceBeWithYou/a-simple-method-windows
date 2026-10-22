; 22-stretch-ring-drop: stretch ring drop
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_ring_drop:PROC
main PROC
    ; TODO: write ex_22_stretch_ring_drop in this file.
    call    ex_22_stretch_ring_drop
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
