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

main PROC FRAME
    push    rbx
    .pushreg rbx
    .endprolog
    
    mov     al, 182         ; 0b10110110
    xor     bl, bl          ; Parity accumulator
    
    ; TODO: Loop 8 times, rotating and XORing bit 0 into accumulator
    
    movzx   ecx, bl
    and     ecx, 1          ; Keep only parity bit
    pop     rbx
    call    ExitProcess

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
