; 23-stretch-bezier-eval.asm: Bezier curve eval at t, exit coord
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_23_stretch_bezier_eval:PROC
main PROC
    ; TODO: implement ex_23_stretch_bezier_eval (student routine; defined in solutions/).
    call    ex_23_stretch_bezier_eval
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
