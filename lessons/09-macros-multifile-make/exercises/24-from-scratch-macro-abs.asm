; 24-from-scratch-macro-abs.asm (from scratch)
; ABS macro with LOCAL label, exit 9.

.CODE
EXTRN ExitProcess:PROC

; TODO: AbsVal MACRO reg; LOCAL skip; cmp reg, 0; jge skip; neg reg; skip:; ENDM

main PROC
    mov rax, -9
    ; TODO: AbsVal rax
    mov ecx, eax
    mov ecx, 1
    call ExitProcess
main ENDP
END
