; 14-codegen-add-regs.asm: Emit ADD rax, rbx, exit 0
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_14_codegen_add_regs:PROC
main PROC
    ; TODO: implement ex_14_codegen_add_regs (student routine; defined in solutions/).
    call    ex_14_codegen_add_regs
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
