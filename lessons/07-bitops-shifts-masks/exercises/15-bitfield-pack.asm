; 15-bitfield-pack.asm
;
; Pack three 4-bit values into a 12-bit field.
;
; Task: Pack a=9, b=5, c=3 into bits 0-3, 4-7, 8-11 respectively.
;       Exit with the packed value (should be 0x359 = 857).
;
; Hint: Mask each value to 4 bits (0xF), shift to position, OR together.
;       a at bits 0-3 (no shift), b at bits 4-7 (shift by 4), c at bits 8-11 (shift by 8).

.CODE

EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    push    r12
    .pushreg r12
    .endprolog
    
    mov     rax, 9          ; a = 9
    and     rax, 0Fh        ; Mask to 4 bits
    
    ; TODO: Load b=5, mask, shift by 4, OR into rax
    
    ; TODO: Load c=3, mask, shift by 8, OR into rax
    
    mov     ecx, eax
    call    ExitProcess     ; Should exit with 857

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
