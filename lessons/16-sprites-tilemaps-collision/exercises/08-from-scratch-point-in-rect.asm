; Exercise: 08-from-scratch-point-in-rect
;
; FROM SCRATCH: point in rect -> 1.
; Expected stdout: (none)
;
; Contract: implement `ex_08_from_scratch_point_in_rect` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_08_from_scratch_point_in_rect:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_08_from_scratch_point_in_rect in this file.
    call    ex_08_from_scratch_point_in_rect
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
