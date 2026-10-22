; 08-from-scratch-point-in-rect: from scratch point in rect
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_08_from_scratch_point_in_rect:PROC
main PROC
    ; TODO: implement ex_08_from_scratch_point_in_rect (student routine; defined in solutions/).
    call    ex_08_from_scratch_point_in_rect
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
