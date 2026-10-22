; 17-while-codegen.asm: Generate while-loop jump, exit 0
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_17_while_codegen:PROC
main PROC
    ; TODO: implement ex_17_while_codegen (student routine; defined in solutions/).
    call    ex_17_while_codegen
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
