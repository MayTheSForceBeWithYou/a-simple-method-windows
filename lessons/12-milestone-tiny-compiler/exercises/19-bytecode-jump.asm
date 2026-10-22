; Exercise: 19-bytecode-jump
;
; Exercise 19: bytecode jump
; Bytecode: JMP +2 over LOAD 99, LOAD 5, HALT; exit 5.
;
; Contract: implement `ex_19_bytecode_jump` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 5
;

; 19-bytecode-jump.asm: Bytecode jump instruction (set IP), exit 0
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_bytecode_jump:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_19_bytecode_jump in this file.
    call    ex_19_bytecode_jump
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
