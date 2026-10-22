; 17-while-codegen.asm: Generate while-loop jump, exit 0
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_17_while_codegen:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_17_while_codegen in this file.
    call    ex_17_while_codegen
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
