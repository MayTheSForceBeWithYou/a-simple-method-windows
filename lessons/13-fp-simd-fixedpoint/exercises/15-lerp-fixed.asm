; Exercise: 15-lerp-fixed
;
; lerp(0,10,0.5) ~5 with Q16 t=1<<15; exit 5.
;
; Contract: implement `ex_15_lerp_fixed` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 5
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_15_lerp_fixed:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_15_lerp_fixed in this file.
    call    ex_15_lerp_fixed
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
