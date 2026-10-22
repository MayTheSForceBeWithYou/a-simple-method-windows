; 11-ll-push-front
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_11_ll_push_front:PROC
main PROC
    ; TODO: implement ex_11_ll_push_front (student routine; defined in solutions/).
    call    ex_11_ll_push_front
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
