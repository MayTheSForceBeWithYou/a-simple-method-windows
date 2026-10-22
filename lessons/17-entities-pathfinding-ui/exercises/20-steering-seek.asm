; 20-steering-seek: steering seek
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_steering_seek:PROC
main PROC
    ; TODO: write ex_20_steering_seek in this file.
    call    ex_20_steering_seek
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
