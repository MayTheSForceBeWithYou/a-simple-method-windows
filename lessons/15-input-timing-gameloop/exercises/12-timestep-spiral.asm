; Exercise: 12-timestep-spiral
;
; Spiral of death guard: max 3 catchup steps; given 100ms dt step 16 -> would be 6, clamp 3; exit 3.
; Expected stdout: (none)
;
; Contract: implement `ex_12_timestep_spiral` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_12_timestep_spiral:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_12_timestep_spiral in this file.
    call    ex_12_timestep_spiral
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
