; 22-stretch-ring-drop: stretch ring drop
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_ring_drop:PROC
main PROC
    ; TODO: implement ex_22_stretch_ring_drop (student routine; defined in solutions/).
    call    ex_22_stretch_ring_drop
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
