; 10-chord: chord
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_10_chord:PROC
main PROC
    ; TODO: implement ex_10_chord (student routine; defined in solutions/).
    call    ex_10_chord
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
