; 24-from-scratch-fb-size: from scratch fb size
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_24_from_scratch_fb_size:PROC
main PROC
    ; TODO: implement ex_24_from_scratch_fb_size (student routine; defined in solutions/).
    call    ex_24_from_scratch_fb_size
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
