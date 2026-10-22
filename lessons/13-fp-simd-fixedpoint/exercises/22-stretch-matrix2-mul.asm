; 22-stretch-matrix2-mul
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_matrix2_mul:PROC
main PROC
    ; TODO: implement ex_22_stretch_matrix2_mul (student routine; defined in solutions/).
    call    ex_22_stretch_matrix2_mul
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
