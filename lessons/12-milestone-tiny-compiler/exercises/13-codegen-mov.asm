; 13-codegen-mov.asm: Emit MOV between registers, exit 0
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_13_codegen_mov:PROC
main PROC
    ; TODO: implement ex_13_codegen_mov (student routine; defined in solutions/).
    call    ex_13_codegen_mov
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
