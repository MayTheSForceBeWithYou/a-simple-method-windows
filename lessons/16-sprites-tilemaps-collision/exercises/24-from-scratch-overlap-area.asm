; 24-from-scratch-overlap-area: from scratch overlap area
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_24_from_scratch_overlap_area:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_24_from_scratch_overlap_area in this file.
    call    ex_24_from_scratch_overlap_area
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
