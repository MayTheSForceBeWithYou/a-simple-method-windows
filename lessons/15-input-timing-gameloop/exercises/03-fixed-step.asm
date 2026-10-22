; Exercise: 03-fixed-step
;
; Exercise 03: fixed step
; step=16ms units; 50ms -> 3 steps; exit 3.
; Expected stdout: (none)
;
; Contract: implement `ex_03_fixed_step` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;

; 03-fixed-step: fixed step
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_03_fixed_step:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_03_fixed_step in this file.
    call    ex_03_fixed_step
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
