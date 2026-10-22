; 24-from-scratch-ntz.asm (from scratch)
;
; Count trailing zeros (number of zeros at the right before first 1 bit).
;
; Task: Count trailing zeros in 0b10101000 (168).
;       There are 3 trailing zeros. Exit with the count.
;
; Hint: Loop: test bit 0. If 0, increment counter and shift right.
;       If 1, stop. Return counter.

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_24_from_scratch_ntz:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_24_from_scratch_ntz (student routine; defined in solutions/).
    call    ex_24_from_scratch_ntz
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
