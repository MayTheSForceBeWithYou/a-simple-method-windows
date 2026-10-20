; 07-extract-bitfield.asm
;
; Extract a bitfield by shifting and masking.
;
; Task: Extract a 5-bit field starting at position 3 from value 0x1F8.
;       The field spans bits 3-7 and has value 31 (0b11111).
;       Exit with the extracted value.
;
; Hint: To extract a field at position P with width W:
;       1. Shift right by P to move field to bit 0
;       2. Mask with (2^W - 1) to keep only W bits

.CODE

EXTRN ExitProcess:PROC

main PROC
    mov     rax, 1F8h       ; Value = 0b111111000
    
    ; TODO: Shift right by 3 to move bits 3-7 to bits 0-4
    .ERR <TODO: Insert SHR instruction to shift right by 3>
    
    ; TODO: Mask to 5 bits (2^5 - 1 = 31 = 0x1F)
    .ERR <TODO: Insert AND instruction with mask 0x1F>
    
    mov     ecx, eax
    call    ExitProcess     ; Should exit with 31
main ENDP

END
