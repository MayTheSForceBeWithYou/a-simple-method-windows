; 18-guest-happiness: guest happiness
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_18_guest_happiness:PROC
main PROC
    ; TODO: implement ex_18_guest_happiness (student routine; defined in solutions/).
    call    ex_18_guest_happiness
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
