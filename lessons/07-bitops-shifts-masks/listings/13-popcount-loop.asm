; 13-popcount-loop.asm
;
; Purpose: Count set bits (popcount) using a loop
; Expected exit code: 3
; Expected stdout: (none)
;
; Implements popcount by shifting right and counting each set bit 0.
; For value 0b1011 (decimal 11), there are 3 set bits.

.CODE

EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    .endprolog
    
    mov     rbx, 11         ; Value = 0b1011 (3 set bits)
    xor     rax, rax        ; counter = 0
    
popcount_loop:
    test    rbx, rbx
    jz      done
    
    test    rbx, 1          ; Is bit 0 set?
    jz      skip_inc
    inc     rax             ; Yes, count it
    
skip_inc:
    shr     rbx, 1          ; Shift right
    jmp     popcount_loop
    
done:
    ; rax = count of 1 bits = 3
    mov     ecx, eax
    pop     rbx
    call    ExitProcess     ; Exit with 3
main ENDP

END
