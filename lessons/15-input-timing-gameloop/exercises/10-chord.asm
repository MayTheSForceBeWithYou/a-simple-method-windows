; 10-chord: chord
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_10_chord:PROC
main PROC
    ; TODO: write ex_10_chord in this file.
    call    ex_10_chord
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
