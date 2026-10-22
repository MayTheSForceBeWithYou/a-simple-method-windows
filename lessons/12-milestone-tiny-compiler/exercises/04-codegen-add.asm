; 04-codegen-add.asm: Generate ADD instruction sequence, exit 0
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_04_codegen_add:PROC
main PROC
    ; TODO: implement ex_04_codegen_add (student routine; defined in solutions/).
    call    ex_04_codegen_add
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
