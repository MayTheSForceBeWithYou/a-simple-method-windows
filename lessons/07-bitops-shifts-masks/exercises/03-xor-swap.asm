; 03-xor-swap.asm
;
; Swap two registers using the XOR swap algorithm.
;
; Task: Start with RAX = 10, RBX = 20.
;       Use three XOR operations to swap them.
;       Exit with RAX (should be 20 after swap).
;
; Hint: The XOR swap pattern is:
;       xor a, b
;       xor b, a
;       xor a, b

.CODE

EXTRN ExitProcess:PROC

main PROC
    mov     rax, 10
    mov     rbx, 20
    
    ; TODO: XOR swap algorithm (three XORs)
    
    mov     ecx, eax
    call    ExitProcess     ; Should exit with 20

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
