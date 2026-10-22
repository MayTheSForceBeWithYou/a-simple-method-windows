; 03-list-node
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_03_list_node:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_03_list_node in this file.
    call    ex_03_list_node
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
