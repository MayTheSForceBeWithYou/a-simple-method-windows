; 06-popcount-naive.asm
;
; Implement popcount (count set bits) using a loop.
;
; Task: Count the number of 1 bits in the value 0b10110111 (decimal 183).
;       The value has 6 set bits. Exit with the count.
;
; Hint: Use a loop that:
;       - Checks if bit 0 is set with TEST reg, 1
;       - Increments a counter if set
;       - Shifts right by 1
;       - Repeats until the value is zero

.CODE

EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    .endprolog
    
    mov     rbx, 183        ; Value = 0b10110111 (6 set bits)
    xor     rax, rax        ; counter = 0
    
    ; TODO: Implement popcount loop
    
    mov     ecx, eax
    pop     rbx
    call    ExitProcess     ; Should exit with 6

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
