; Exercise: 22-stretch-sat-axes
;
; Exercise 22: stretch sat axes
; STRETCH: SAT axis count for AABB=2; exit 2.
; Expected stdout: (none)
;
; Contract: implement `ex_22_stretch_sat_axes` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;

; 22-stretch-sat-axes: stretch sat axes
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_sat_axes:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_22_stretch_sat_axes in this file.
    call    ex_22_stretch_sat_axes
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
