; 11-component-mask: component mask
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_11_component_mask:PROC
main PROC
    ; TODO: write ex_11_component_mask in this file.
    call    ex_11_component_mask
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
