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

main PROC FRAME
    push    rbx
    .pushreg rbx
    push    r12
    .pushreg r12
    .endprolog
    
    mov     al, 180         ; 0b10110100
    xor     bl, bl          ; Result accumulator
    
    ; TODO: Reverse bits of AL into BL
    .ERR <TODO: Implement bit reversal loop or algorithm>
    
    movzx   ecx, bl
    pop     r12
    pop     rbx
    call    ExitProcess     ; Should exit with 45
main ENDP

END
