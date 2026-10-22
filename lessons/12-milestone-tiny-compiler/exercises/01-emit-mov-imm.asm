; Exercise: 01-emit-mov-imm
;
; Compiler-ish: 'emit' by writing value 42 to out cell; exit 42.
;
; Contract: implement `ex_01_emit_mov_imm` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_01_emit_mov_imm:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_01_emit_mov_imm in this file.
    call    ex_01_emit_mov_imm
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
