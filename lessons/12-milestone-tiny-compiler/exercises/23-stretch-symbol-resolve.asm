; 23-stretch-symbol-resolve.asm: Resolve symbol address, exit address
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_23_stretch_symbol_resolve:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_23_stretch_symbol_resolve in this file.
    call    ex_23_stretch_symbol_resolve
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
