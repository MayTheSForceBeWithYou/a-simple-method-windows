; 16-anim-frame: anim frame
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_16_anim_frame:PROC
main PROC
    ; TODO: implement ex_16_anim_frame (student routine; defined in solutions/).
    call    ex_16_anim_frame
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
