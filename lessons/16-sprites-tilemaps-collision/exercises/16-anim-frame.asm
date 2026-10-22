; 16-anim-frame: anim frame
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_16_anim_frame:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_16_anim_frame in this file.
    call    ex_16_anim_frame
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
