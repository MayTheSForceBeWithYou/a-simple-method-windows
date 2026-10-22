; 06-symbol-slot.asm: Allocate variable slot (increment counter), exit slot number
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_06_symbol_slot:PROC
main PROC
    ; TODO: implement ex_06_symbol_slot (student routine; defined in solutions/).
    call    ex_06_symbol_slot
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
