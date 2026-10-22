; 01-and-mask.asm
;
; Use AND to extract the low nibble (low 4 bits) from a value.
;
; Task: Load 0ABh into AL, then use AND with an appropriate mask
;       to keep only bits 0-3 (the low nibble).
;       Exit with the result (should be 00Bh = 11).
;
; Hint: To keep bits 0-3, AND with a mask that has 1s in positions 0-3
;       and 0s everywhere else. What hexadecimal value is 0b00001111?

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_01_and_mask:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_01_and_mask (student routine; defined in solutions/).
    call    ex_01_and_mask
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
