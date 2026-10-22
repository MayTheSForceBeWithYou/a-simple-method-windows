; 16-if-codegen.asm: Generate if-branch jump, exit 0
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_16_if_codegen:PROC
main PROC
    ; TODO: write ex_16_if_codegen in this file.
    call    ex_16_if_codegen
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
