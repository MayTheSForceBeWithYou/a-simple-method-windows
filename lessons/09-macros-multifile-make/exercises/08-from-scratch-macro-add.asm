; 08-from-scratch-macro-add.asm (from scratch)
; Define ADD_IMM macro, use it: mov rax, 40; ADD_IMM rax, 2; exit 42.

.CODE
EXTRN ExitProcess:PROC

; TODO: Define ADD_IMM MACRO reg, imm; add reg, imm; ENDM
.ERR <TODO: Define ADD_IMM macro>

main PROC
    mov rax, 40
    ; TODO: ADD_IMM rax, 2
    .ERR <TODO: Invoke ADD_IMM>
    mov ecx, eax
    call ExitProcess
main ENDP
END
