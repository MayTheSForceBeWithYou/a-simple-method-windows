; 11-ll-push-front
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_11_ll_push_front:PROC
main PROC
    ; TODO: write ex_11_ll_push_front in this file.
    call    ex_11_ll_push_front
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
