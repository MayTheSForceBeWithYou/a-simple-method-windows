; 08-from-scratch-rol.asm (from scratch)
;
; Use ROL (rotate left) to move bits without losing them.
;
; Task: Load 0x81 (binary 10000001) into AL.
;       Rotate left by 1 bit.
;       Exit with the result (should be 0x03 = 3, binary 00000011).
;
; Hint: ROL shifts bits left, but the bit that exits the MSB
;       re-enters at the LSB. No bit is lost.
;       After rotating 10000001 left by 1, you get 00000011.

.CODE

EXTRN ExitProcess:PROC

main PROC
    mov     al, 81h         ; binary 10000001
    
    ; TODO: Rotate left by 1
    
    movzx   ecx, al
    call    ExitProcess     ; Should exit with 3

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
