; 24-from-scratch-vector-push
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_24_from_scratch_vector_push:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_24_from_scratch_vector_push in this file.
    call    ex_24_from_scratch_vector_push
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
