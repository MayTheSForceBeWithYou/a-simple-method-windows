; 15-count-leading-zeros.asm
;
; Purpose: Count leading zeros (clz) in a 16-bit value
; Expected exit code: 8
; Expected stdout: (none)
;
; Shifts left until bit 15 is set, counting shifts.
; For 0x00F0 (binary 0000000011110000), there are 8 leading zeros.

.CODE

EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    .endprolog
    
    mov     ax, 0F0h        ; Value = 0x00F0 (8 leading zeros)
    xor     rbx, rbx        ; counter = 0
    
clz_loop:
    cmp     rbx, 16         ; Processed all 16 bits?
    jge     done
    
    test    ax, 8000h       ; Is bit 15 set?
    jnz     done
    
    inc     rbx             ; Count this leading zero
    shl     ax, 1           ; Shift left
    jmp     clz_loop
    
done:
    ; rbx = count of leading zeros = 8
    mov     ecx, ebx
    call    ExitProcess     ; Exit with 8
main ENDP

END
