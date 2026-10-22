; 23-stretch-bit-reverse8.asm (stretch)
;
; Reverse the bits of an 8-bit value.
;
; Task: Reverse bits of 0b10110100 (180).
;       Result should be 0b00101101 (45).
;       Exit with reversed value.
;
; Hint: One method: loop 8 times, extracting each bit from input
;       and shifting it into output from the opposite end.
;       Or use rotates and masks to swap bit positions.

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_23_stretch_bit_reverse8:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_23_stretch_bit_reverse8 (student routine; defined in solutions/).
    call    ex_23_stretch_bit_reverse8
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
