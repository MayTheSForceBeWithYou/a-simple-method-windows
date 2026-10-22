; 23-stretch-haptic-stub: stretch haptic stub
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_23_stretch_haptic_stub:PROC
main PROC
    ; TODO: implement ex_23_stretch_haptic_stub (student routine; defined in solutions/).
    call    ex_23_stretch_haptic_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
