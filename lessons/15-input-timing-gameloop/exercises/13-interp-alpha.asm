; Exercise: 13-interp-alpha
;
; alpha = accum/step with accum=8 step=16 -> 0.5 as Q16 08000h>>15 =1? Use alpha in 0..100 =50; exit 50.
; Expected stdout: (none)
;
; Contract: implement `ex_13_interp_alpha` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 50
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_13_interp_alpha:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_13_interp_alpha in this file.
    call    ex_13_interp_alpha
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
