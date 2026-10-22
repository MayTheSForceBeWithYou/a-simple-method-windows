; Exercise: 14-codegen-add-regs
;
; v1=10 v2=32; add into v1; exit 42.
;
; Contract: implement `ex_14_codegen_add_regs` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;
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
