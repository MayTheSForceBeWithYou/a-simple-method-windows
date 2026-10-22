; 16-pitch-bytes: pitch bytes
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_16_pitch_bytes:PROC
main PROC
    ; TODO: implement ex_16_pitch_bytes (student routine; defined in solutions/).
    call    ex_16_pitch_bytes
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
