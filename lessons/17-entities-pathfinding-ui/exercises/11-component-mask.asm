; 11-component-mask: component mask
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_11_component_mask:PROC
main PROC
    ; TODO: implement ex_11_component_mask (student routine; defined in solutions/).
    call    ex_11_component_mask
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
