; 22-stretch-coaster-excitement: stretch coaster excitement
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_coaster_excitement:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_22_stretch_coaster_excitement in this file.
    call    ex_22_stretch_coaster_excitement
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
