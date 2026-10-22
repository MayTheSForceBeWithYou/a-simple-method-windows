; Exercise: 23-stretch-bezier-eval
;
; Exercise 23: stretch bezier eval
; Linear bezier P0=0 P1=10 at t=0.5; exit 5.
;
; Contract: implement `ex_23_stretch_bezier_eval` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 5
;

; 23-stretch-bezier-eval.asm: Bezier curve eval at t, exit coord
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_23_stretch_bezier_eval:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_23_stretch_bezier_eval in this file.
    call    ex_23_stretch_bezier_eval
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
