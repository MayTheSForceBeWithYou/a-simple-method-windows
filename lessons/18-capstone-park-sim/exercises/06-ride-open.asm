; 06-ride-open: ride open
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_06_ride_open:PROC
main PROC
    ; TODO: write ex_06_ride_open in this file.
    call    ex_06_ride_open
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
