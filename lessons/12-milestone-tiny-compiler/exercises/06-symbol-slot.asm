; Exercise: 06-symbol-slot
;
; Exercise 06: symbol slot
; Bind name slot 0 to 42; lookup exit 42.
;
; Contract: implement `ex_06_symbol_slot` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;

; 06-symbol-slot.asm: Allocate variable slot (increment counter), exit slot number
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_06_symbol_slot:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_06_symbol_slot in this file.
    call    ex_06_symbol_slot
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
