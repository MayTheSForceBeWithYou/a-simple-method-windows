; Exercise: 23-stretch-chunk-coords
;
; STRETCH: chunk = tile>>4; tile=40 -> 2; exit 2.
; Expected stdout: (none)
;
; Contract: implement `ex_23_stretch_chunk_coords` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_23_stretch_chunk_coords:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_23_stretch_chunk_coords in this file.
    call    ex_23_stretch_chunk_coords
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
