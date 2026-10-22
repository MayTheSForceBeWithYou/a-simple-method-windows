; 06-ride-open: ride open
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_06_ride_open:PROC
main PROC
    ; TODO: implement ex_06_ride_open (student routine; defined in solutions/).
    call    ex_06_ride_open
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
