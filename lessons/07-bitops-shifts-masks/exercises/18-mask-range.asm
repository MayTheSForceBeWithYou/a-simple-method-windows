; 18-mask-range.asm
;
; Create a mask for a range of bits.
;
; Task: Generate a mask with bits 2-5 set (value 0b00111100 = 0x3C = 60).
;       Exit with the mask.
;
; Hint: One method:
;       - Create mask with N bits set: (1 << N) - 1
;       - Shift it left to position
;       Example: (1 << 4) - 1 = 15 (bits 0-3), shift left by 2 → 60 (bits 2-5)

.CODE

EXTRN ExitProcess:PROC

main PROC
    ; TODO: Compute mask with bits 2-5 set
    
    mov     ecx, eax
    call    ExitProcess     ; Should exit with 60

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
