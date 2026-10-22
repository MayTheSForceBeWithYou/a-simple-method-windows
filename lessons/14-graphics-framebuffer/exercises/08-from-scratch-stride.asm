; 08-from-scratch-stride: from scratch stride
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_08_from_scratch_stride:PROC
main PROC
    ; TODO: implement ex_08_from_scratch_stride (student routine; defined in solutions/).
    call    ex_08_from_scratch_stride
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
