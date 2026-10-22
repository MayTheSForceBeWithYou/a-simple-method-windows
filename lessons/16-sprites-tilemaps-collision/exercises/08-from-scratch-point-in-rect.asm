; 08-from-scratch-point-in-rect: from scratch point in rect
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_08_from_scratch_point_in_rect:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_08_from_scratch_point_in_rect in this file.
    call    ex_08_from_scratch_point_in_rect
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
