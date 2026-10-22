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
