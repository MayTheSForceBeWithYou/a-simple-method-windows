; Exercise: 24-from-scratch-loop-phases
;
; FROM SCRATCH: phases input,update,render counted; 3 phases * 2 frames = 6; exit 6.
; Expected stdout: (none)
;
; Contract: implement `ex_24_from_scratch_loop_phases` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 6
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_24_from_scratch_loop_phases:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_24_from_scratch_loop_phases in this file.
    call    ex_24_from_scratch_loop_phases
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
