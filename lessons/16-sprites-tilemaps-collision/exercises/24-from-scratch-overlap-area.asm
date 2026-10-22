; 24-from-scratch-overlap-area: from scratch overlap area
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_24_from_scratch_overlap_area:PROC
main PROC
    ; TODO: implement ex_24_from_scratch_overlap_area (student routine; defined in solutions/).
    call    ex_24_from_scratch_overlap_area
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
