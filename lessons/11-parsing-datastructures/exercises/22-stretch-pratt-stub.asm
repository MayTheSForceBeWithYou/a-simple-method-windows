; 22-stretch-pratt-stub
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_pratt_stub:PROC
main PROC
    ; TODO: implement ex_22_stretch_pratt_stub (student routine; defined in solutions/).
    call    ex_22_stretch_pratt_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
