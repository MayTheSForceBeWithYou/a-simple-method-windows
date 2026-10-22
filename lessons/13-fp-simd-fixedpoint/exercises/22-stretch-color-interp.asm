; Exercise: 22-stretch-color-interp
;
; Exercise 22: stretch color interp
; Lerp 0..100 at t=0.5 in Q16.16; exit 50.
;
; Contract: implement `ex_22_stretch_color_interp` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 50
;

; 22-stretch-color-interp.asm: Color interpolation RGB Q16.16
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_color_interp:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_22_stretch_color_interp in this file.
    call    ex_22_stretch_color_interp
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
