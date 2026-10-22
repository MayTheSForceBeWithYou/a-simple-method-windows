; 18-call-codegen.asm: Generate call instruction, exit 0

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_18_call_codegen:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_18_call_codegen (student routine; defined in solutions/).
    call    ex_18_call_codegen
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
