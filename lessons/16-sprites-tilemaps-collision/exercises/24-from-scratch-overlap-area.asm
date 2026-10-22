; Exercise: 24-from-scratch-overlap-area
;
; FROM SCRATCH: overlap width 2 height 3 area 6; exit 6.
; Expected stdout: (none)
;
; Contract: implement `ex_24_from_scratch_overlap_area` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 6
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_24_from_scratch_overlap_area:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_24_from_scratch_overlap_area in this file.
    call    ex_24_from_scratch_overlap_area
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
