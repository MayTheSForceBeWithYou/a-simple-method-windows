; 07-peep-happy: peep happy
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_07_peep_happy:PROC
main PROC
    ; TODO: implement ex_07_peep_happy (student routine; defined in solutions/).
    call    ex_07_peep_happy
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
