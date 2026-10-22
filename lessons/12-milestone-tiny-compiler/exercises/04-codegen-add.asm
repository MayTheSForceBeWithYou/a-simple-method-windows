; 04-codegen-add.asm: Generate ADD instruction sequence, exit 0
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_04_codegen_add:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_04_codegen_add in this file.
    call    ex_04_codegen_add
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
