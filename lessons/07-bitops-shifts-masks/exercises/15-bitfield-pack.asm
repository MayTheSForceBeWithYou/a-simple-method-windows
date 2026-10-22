; 15-bitfield-pack.asm
;
; Pack three 4-bit values into a 12-bit field.
;
; Task: Pack a=9, b=5, c=3 into bits 0-3, 4-7, 8-11 respectively.
;       Exit with the packed value (should be 0x359 = 857).
;
; Hint: Mask each value to 4 bits (0xF), shift to position, OR together.
;       a at bits 0-3 (no shift), b at bits 4-7 (shift by 4), c at bits 8-11 (shift by 8).

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_15_bitfield_pack:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_15_bitfield_pack (student routine; defined in solutions/).
    call    ex_15_bitfield_pack
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
