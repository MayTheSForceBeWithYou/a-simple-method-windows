; 11-unpack-bitfield.asm
;
; Purpose: Extract a bitfield by shifting and masking
; Expected exit code: 2
; Expected stdout: (none)
;
; Extracts field 'b' (bits 3-5, width 3) from packed value 0x55.
; To unpack: shift field to bit 0, then mask to width.

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     rax, 055h       ; Packed value = 0b001_010_101 = 0x55
    
    ; Extract 'b' (bits 3-5, width 3):
    shr     rax, 3          ; Shift bits 3-5 down to bits 0-2
    and     rax, 7          ; Mask to 3 bits (2^3 - 1 = 7)
    
    ; Result: rax = 2 (the middle 3-bit field)
    
    mov     ecx, eax
    call    ExitProcess     ; Exit with 2
main ENDP

END
