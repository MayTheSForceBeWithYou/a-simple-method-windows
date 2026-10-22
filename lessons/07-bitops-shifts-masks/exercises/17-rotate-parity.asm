; 17-rotate-parity.asm
;
; Use rotate to compute simple parity (XOR of all bits).
;
; Task: Compute parity of 8-bit value 0b10110110 (182).
;       Rotate and XOR bits to accumulate parity into bit 0.
;       Exit with parity bit (0 or 1).
;
; Hint: One approach: rotate right, XOR into accumulator, repeat 8 times.
;       Bit 0 ends up holding XOR of all original bits (parity).

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_17_rotate_parity:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_17_rotate_parity (student routine; defined in solutions/).
    call    ex_17_rotate_parity
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
