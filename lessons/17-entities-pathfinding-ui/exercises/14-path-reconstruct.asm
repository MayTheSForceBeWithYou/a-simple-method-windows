; 14-path-reconstruct: path reconstruct
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_14_path_reconstruct:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_14_path_reconstruct in this file.
    call    ex_14_path_reconstruct
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
