; 23-stretch-haptic-stub: stretch haptic stub
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_23_stretch_haptic_stub:PROC
main PROC
    ; TODO: write ex_23_stretch_haptic_stub in this file.
    call    ex_23_stretch_haptic_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
