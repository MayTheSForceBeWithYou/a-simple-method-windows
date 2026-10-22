; 14-codegen-add-regs.asm: Emit ADD rax, rbx, exit 0
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_14_codegen_add_regs:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_14_codegen_add_regs in this file.
    call    ex_14_codegen_add_regs
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
