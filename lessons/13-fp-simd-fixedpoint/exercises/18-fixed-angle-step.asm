; Exercise: 18-fixed-angle-step
;
; Exercise 18: fixed angle step
; Angle += delta; wrap 360; 350+20 -> 10; exit 10.
;
; Contract: implement `ex_18_fixed_angle_step` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 10
;

; 18-fixed-angle-step
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_18_fixed_angle_step:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_18_fixed_angle_step in this file.
    call    ex_18_fixed_angle_step
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
