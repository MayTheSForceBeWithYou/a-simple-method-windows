; 19-debug-sign-shift.asm
;
; Debug a sign-extension bug when shifting.
;
; Task: Given value -1 (0xFF in AL), extend to 64 bits then shift right by 1.
;       If you use MOVZX (zero-extend), SHR gives 127.
;       If you use MOVSX (sign-extend), SAR gives -1 (255 in low byte).
;
; Use MOVSX and SAR. Exit with low byte of result.
;
; Hint: MOVSX sign-extends; SAR preserves sign. Together they correctly
;       handle signed values across size changes.

.CODE

EXTRN ExitProcess:PROC

main PROC
    mov     al, 0FFh        ; -1 as signed byte
    
    ; TODO: Sign-extend to 64 bits with MOVSX
    
    ; TODO: Shift right arithmetic by 1
    
    mov     ecx, eax
    and     ecx, 0FFh       ; Low byte
    call    ExitProcess     ; Should exit with 255 (0xFF = -1)

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
