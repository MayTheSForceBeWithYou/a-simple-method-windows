; 14-sar-vs-shr.asm
;
; Demonstrate the difference between SAR and SHR on a negative value.
;
; Task: Load -32 into AL (as signed 8-bit: 0xE0 = -32).
;       Use SHR to divide by 4 (shift right by 2).
;       Exit with the result to see the incorrect unsigned result.
;
; Then compare: if you used SAR instead, you'd get -8 (0xF8 = 248).
;
; Hint: SHR on -32 (0xE0) shifts right filling with 0, giving 0x38 = 56.
;       SAR on -32 (0xE0) shifts right preserving sign, giving 0xF8 = 248.

.CODE

EXTRN ExitProcess:PROC

main PROC
    mov     al, 0E0h        ; -32 as signed byte (0xE0 = 224 unsigned)
    
    ; TODO: Use SHR to shift right by 2 (demonstrates wrong result for signed)
    
    movzx   ecx, al
    call    ExitProcess     ; Will exit with 56 (wrong for signed division)

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
