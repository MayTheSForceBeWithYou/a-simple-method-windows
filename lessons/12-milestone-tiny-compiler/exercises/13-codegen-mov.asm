; 13-codegen-mov.asm: Emit MOV between registers, exit 0
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_13_codegen_mov:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_13_codegen_mov in this file.
    call    ex_13_codegen_mov
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
