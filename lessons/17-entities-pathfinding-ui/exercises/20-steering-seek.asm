; 20-steering-seek: steering seek
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_steering_seek:PROC
main PROC
    ; TODO: implement ex_20_steering_seek (student routine; defined in solutions/).
    call    ex_20_steering_seek
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
