; 12-strstr-macro-label.asm
; TWICE macro with two INC, no label collision, exit 2.

.CODE
EXTRN ExitProcess:PROC

; TODO: TWICE MACRO; inc rax; inc rax; ENDM (no labels needed)

main PROC
    xor eax, eax
    ; TODO: TWICE
    mov ecx, eax
    call ExitProcess
main ENDP
END
