; 23-stretch-multiplayer-stub: stretch multiplayer stub
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_23_stretch_multiplayer_stub:PROC
main PROC
    ; TODO: write ex_23_stretch_multiplayer_stub in this file.
    call    ex_23_stretch_multiplayer_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
