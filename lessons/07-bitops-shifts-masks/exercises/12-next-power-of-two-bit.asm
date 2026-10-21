; 12-next-power-of-two-bit.asm
;
; Find the highest set bit and return the next power of 2.
;
; Task: Given 0b00101100 (44), find the highest set bit (bit 5 = 32).
;       Return the next power of 2, which is bit 6 = 64.
;
; Hint: One approach:
;       - Subtract 1, OR with original (spreads 1s down from highest bit)
;       - Add 1 to get next power of 2
;       Example: 44 - 1 = 43, 44 | 43 = 47, 47 + 1 = 48... (adjust logic)
;       Or use a simpler method: shift highest bit left by 1.

.CODE

EXTRN ExitProcess:PROC

main PROC
    mov     rax, 44         ; 0b00101100
    
    ; TODO: Find next power of 2 above highest set bit
    
    mov     ecx, eax
    call    ExitProcess     ; Should exit with 64

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
