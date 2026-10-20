; 24-from-scratch-macro-abs.asm (from scratch)
; ABS macro with LOCAL label, exit 9.

.CODE
EXTRN ExitProcess:PROC

; TODO: AbsVal MACRO reg; LOCAL skip; cmp reg, 0; jge skip; neg reg; skip:; ENDM
.ERR <TODO: Define AbsVal macro with LOCAL>

main PROC
    mov rax, -9
    ; TODO: AbsVal rax
    .ERR <TODO: Invoke AbsVal>
    mov ecx, eax
    call ExitProcess
main ENDP
END
