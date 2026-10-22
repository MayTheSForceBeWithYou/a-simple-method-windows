; 03-list-node
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_03_list_node:PROC
main PROC
    ; TODO: implement ex_03_list_node (student routine; defined in solutions/).
    call    ex_03_list_node
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
