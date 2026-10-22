; 07-extract-bitfield.asm
;
; Extract a bitfield by shifting and masking.
;
; Task: Extract a 5-bit field starting at position 3 from value 01F8h.
;       The field spans bits 3-7 and has value 31 (0b11111).
;       Exit with the extracted value.
;
; Hint: To extract a field at position P with width W:
;       1. Shift right by P to move field to bit 0
;       2. Mask with (2^W - 1) to keep only W bits

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_07_extract_bitfield:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_07_extract_bitfield in this file.
    call    ex_07_extract_bitfield
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
