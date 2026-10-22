; Exercise: 08-from-scratch-loop-counter
;
; FROM SCRATCH: 10 frame iterations; exit 10.
; Expected stdout: (none)
;
; Contract: implement `ex_08_from_scratch_loop_counter` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 10
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_08_from_scratch_loop_counter:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_08_from_scratch_loop_counter in this file.
    call    ex_08_from_scratch_loop_counter
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
