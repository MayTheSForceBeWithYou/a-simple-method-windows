; 10-bit-set-clear.asm
;
; Set and clear specific bits using OR and AND.
;
; Task: Start with RAX = 0FFh (all low 8 bits set).
;       Clear bit 2 (turn it off).
;       Exit with the result (should be 0FBh = 251).
;
; Hint: To clear bit N, AND with ~(1 << N).
;       In MASM, you can compute the mask: NOT 4 = NOT (1 << 2).
;       Or directly: AND with 0FBh (which is 0FFh with bit 2 cleared).

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_10_bit_set_clear:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_10_bit_set_clear (student routine; defined in solutions/).
    call    ex_10_bit_set_clear
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
