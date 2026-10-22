; 16-pitch-bytes: pitch bytes
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_16_pitch_bytes:PROC
main PROC
    ; TODO: write ex_16_pitch_bytes in this file.
    call    ex_16_pitch_bytes
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
