; Exercise: 05-bytecode-interp
;
; Exercise 05: bytecode interp
; Bytes: LOAD 4, LOAD 5, ADD, HALT. Exit 9.
;
; Contract: implement `ex_05_bytecode_interp` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 9
;

; 05-bytecode-interp.asm: Interpret bytecode: LOAD 10, LOAD 20, ADD, HALT → exit 30
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_05_bytecode_interp:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_05_bytecode_interp in this file.
    call    ex_05_bytecode_interp
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
