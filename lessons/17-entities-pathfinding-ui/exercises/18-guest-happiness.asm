; 18-guest-happiness: guest happiness
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_18_guest_happiness:PROC
main PROC
    ; TODO: write ex_18_guest_happiness in this file.
    call    ex_18_guest_happiness
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
