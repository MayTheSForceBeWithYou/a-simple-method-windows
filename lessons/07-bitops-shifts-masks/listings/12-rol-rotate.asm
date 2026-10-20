; 12-rol-rotate.asm
;
; Purpose: Demonstrate ROL (rotate left) instruction
; Expected exit code: 1
; Expected stdout: (none)
;
; ROL shifts bits left, wrapping the MSB around to the LSB.
; Unlike SHL, no bit is lost.

.CODE

EXTRN ExitProcess:PROC

main PROC
    mov     al, 80h         ; al = 10000000 binary
    rol     al, 1           ; Rotate left by 1
    
    ; Bit 7 (the only set bit) moves to bit 0
    ; Result: al = 00000001 binary = 1
    
    movzx   ecx, al
    call    ExitProcess     ; Exit with 1
main ENDP

END
