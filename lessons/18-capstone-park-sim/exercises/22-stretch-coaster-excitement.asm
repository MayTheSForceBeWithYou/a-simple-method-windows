; 22-stretch-coaster-excitement: stretch coaster excitement
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_coaster_excitement:PROC
main PROC
    ; TODO: implement ex_22_stretch_coaster_excitement (student routine; defined in solutions/).
    call    ex_22_stretch_coaster_excitement
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
