; Exercise: 01-emit-mov-imm
;
; Exercise 01: emit mov imm
; Compiler-ish: 'emit' by writing value 42 to out cell; exit 42.
;
; Contract: implement `ex_01_emit_mov_imm` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;

; 01-emit-mov-imm.asm: Emit MOV immediate instruction (x64: mov rax, 42), exit 0
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_01_emit_mov_imm:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_01_emit_mov_imm in this file.
    call    ex_01_emit_mov_imm
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
