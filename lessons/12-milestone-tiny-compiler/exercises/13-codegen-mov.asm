; Exercise: 13-codegen-mov
;
; Exercise 13: codegen mov
; Emit conceptual: store imm 42 into slot; exit 42.
;
; Contract: implement `ex_13_codegen_mov` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;

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
