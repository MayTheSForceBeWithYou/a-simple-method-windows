; Exercise: 22-stretch-matrix2-mul
;
; STRETCH: 2x2 identity * (3,4) -> 3; exit 3 (x).
;
; Contract: implement `ex_22_stretch_matrix2_mul` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_matrix2_mul:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_22_stretch_matrix2_mul in this file.
    call    ex_22_stretch_matrix2_mul
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
