; Exercise: 13-sweep-hit-t
;
; TOI stub t=3; exit 3.
; Expected stdout: (none)
;
; Contract: implement `ex_13_sweep_hit_t` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_13_sweep_hit_t:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_13_sweep_hit_t in this file.
    call    ex_13_sweep_hit_t
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
