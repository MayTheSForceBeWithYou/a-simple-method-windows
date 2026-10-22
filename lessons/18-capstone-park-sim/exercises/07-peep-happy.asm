; 07-peep-happy: peep happy
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_07_peep_happy:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_07_peep_happy in this file.
    call    ex_07_peep_happy
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
