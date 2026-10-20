; 22-stretch-swar-avg.asm (stretch)
;
; Compute average of two unsigned bytes without overflow using SWAR technique.
;
; Task: Compute average of 200 and 180 using formula: (a & b) + ((a ^ b) >> 1).
;       This avoids overflow from (a + b) / 2 when a + b > 255.
;       Exit with the average (should be 190).
;
; Hint: This SWAR (SIMD Within A Register) trick splits the sum into
;       shared bits (a & b) and differing bits ((a ^ b) >> 1).

.CODE

EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    push    r12
    .pushreg r12
    .endprolog
    
    mov     al, 200
    mov     bl, 180
    
    ; TODO: Compute (a & b) + ((a ^ b) >> 1)
    .ERR <TODO: Implement SWAR average formula>
    
    movzx   ecx, al
    pop     r12
    pop     rbx
    call    ExitProcess     ; Should exit with 190
main ENDP

END
