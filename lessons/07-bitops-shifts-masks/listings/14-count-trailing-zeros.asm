; 14-count-trailing-zeros.asm
;
; Purpose: Count trailing zeros (ctz) using a loop
; Expected exit code: 3
; Expected stdout: (none)
;
; Shifts right until bit 0 is set, counting shifts.
; For 0b1011000 (decimal 88), there are 3 trailing zeros.

.CODE

EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    .endprolog
    
    mov     rbx, 88         ; Value = 0b1011000 (3 trailing zeros)
    xor     rax, rax        ; counter = 0
    
ctz_loop:
    test    rbx, 1          ; Is bit 0 set?
    jnz     done
    
    inc     rax             ; Count this zero
    shr     rbx, 1          ; Shift right
    jmp     ctz_loop
    
done:
    ; rax = number of trailing zeros = 3
    mov     ecx, eax
    call    ExitProcess     ; Exit with 3
main ENDP

END
