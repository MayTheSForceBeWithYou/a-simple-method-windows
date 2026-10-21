; 16-bitfield-unpack.asm
;
; Unpack a 4-bit field from bits 4-7 of a packed value.
;
; Task: Given packed value 0x359, extract the field at bits 4-7 (should be 5).
;       Exit with the extracted value.
;
; Hint: Shift right by 4 to move bits 4-7 to bits 0-3, then mask with 0xF.

.CODE

EXTRN ExitProcess:PROC

main PROC
    mov     rax, 359h       ; Packed value = 0x359
    
    ; TODO: Shift right by 4
    
    ; TODO: Mask to 4 bits
    
    mov     ecx, eax
    call    ExitProcess     ; Should exit with 5

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
