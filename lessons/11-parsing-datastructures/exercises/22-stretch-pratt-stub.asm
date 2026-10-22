; 22-stretch-pratt-stub
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_pratt_stub:PROC
main PROC
    ; TODO: write ex_22_stretch_pratt_stub in this file.
    call    ex_22_stretch_pratt_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
