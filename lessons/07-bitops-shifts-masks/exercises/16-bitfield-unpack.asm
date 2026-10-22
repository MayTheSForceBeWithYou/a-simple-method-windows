; 16-bitfield-unpack.asm
;
; Unpack a 4-bit field from bits 4-7 of a packed value.
;
; Task: Given packed value 0359h, extract the field at bits 4-7 (should be 5).
;       Exit with the extracted value.
;
; Hint: Shift right by 4 to move bits 4-7 to bits 0-3, then mask with 0Fh.

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_16_bitfield_unpack:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_16_bitfield_unpack (student routine; defined in solutions/).
    call    ex_16_bitfield_unpack
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
