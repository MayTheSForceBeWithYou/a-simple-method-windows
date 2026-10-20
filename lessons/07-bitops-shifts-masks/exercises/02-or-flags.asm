; 02-or-flags.asm
;
; Use OR to set specific bits (set flags).
;
; Task: Start with RAX = 0.
;       Use OR to set bit 0, then OR again to set bit 3.
;       Exit with the result (should be 0b1001 = 9).
;
; Hint: To set bit N, OR with (1 << N).
;       Bit 0 is 1, bit 3 is 8.

.CODE

EXTRN ExitProcess:PROC

main PROC
    xor     rax, rax        ; Start with 0
    
    ; TODO: Set bit 0 using OR
    .ERR <TODO: Insert OR instruction to set bit 0>
    
    ; TODO: Set bit 3 using OR
    .ERR <TODO: Insert OR instruction to set bit 3>
    
    mov     ecx, eax
    call    ExitProcess     ; Should exit with 9
main ENDP

END
