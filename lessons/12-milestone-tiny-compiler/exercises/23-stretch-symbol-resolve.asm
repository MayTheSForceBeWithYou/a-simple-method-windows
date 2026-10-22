; Exercise: 23-stretch-symbol-resolve
;
; Exercise 23: stretch symbol resolve
; STRETCH: symbol table maps name hash to addr 020h; exit 020h=32.
;
; Contract: implement `ex_23_stretch_symbol_resolve` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 32
;

; 23-stretch-symbol-resolve.asm: Resolve symbol address, exit address
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_23_stretch_symbol_resolve:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_23_stretch_symbol_resolve in this file.
    call    ex_23_stretch_symbol_resolve
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
