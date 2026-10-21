; 11-isolate-lowbit.asm
;
; Isolate the lowest set bit using bitwise trick: x & (-x).
;
; Task: Given value 0b11010100 (212), isolate the lowest set bit.
;       The lowest set bit is bit 2 (value 4).
;       Exit with the isolated bit value.
;
; Hint: The expression (x & -x) isolates the lowest set bit.
;       NEG creates two's complement; ANDing with original isolates lowest 1.

.CODE

EXTRN ExitProcess:PROC

main PROC
    mov     rax, 212        ; 0b11010100
    mov     rbx, rax
    neg     rbx             ; -x
    
    ; TODO: AND rax with rbx to isolate lowest set bit
    
    mov     ecx, eax
    call    ExitProcess     ; Should exit with 4

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
