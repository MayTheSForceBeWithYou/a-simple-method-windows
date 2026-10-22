; 23-stretch-symbol-resolve.asm: Resolve symbol address, exit address
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_23_stretch_symbol_resolve:PROC
main PROC
    ; TODO: implement ex_23_stretch_symbol_resolve (student routine; defined in solutions/).
    call    ex_23_stretch_symbol_resolve
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
