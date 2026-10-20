; 21-gray-code.asm
;
; Convert binary to Gray code using XOR and shift.
;
; Task: Convert binary value 12 (0b1100) to Gray code.
;       Gray code formula: gray = binary ^ (binary >> 1).
;       Exit with Gray code result (should be 10 = 0b1010).
;
; Hint: Copy value to another register, shift right by 1, XOR with original.

.CODE

EXTRN ExitProcess:PROC

main PROC
    mov     rax, 12         ; Binary value = 12
    mov     rbx, rax
    
    ; TODO: Shift rbx right by 1
    .ERR <TODO: Insert SHR rbx, 1>
    
    ; TODO: XOR rax with rbx to get Gray code
    .ERR <TODO: Insert XOR rax, rbx>
    
    mov     ecx, eax
    call    ExitProcess     ; Should exit with 10
main ENDP

END
