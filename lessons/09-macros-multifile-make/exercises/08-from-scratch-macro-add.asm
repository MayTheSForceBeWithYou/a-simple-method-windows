; 08-from-scratch-macro-add.asm (from scratch)
; Define ADD_IMM macro, use it: mov rax, 40; ADD_IMM rax, 2; exit 42.

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_08_from_scratch_macro_add:PROC

; TODO: Define ADD_IMM MACRO reg, imm; add reg, imm; ENDM

main PROC
    sub     rsp, 40
    ; TODO: write ex_08_from_scratch_macro_add in this file.
    call    ex_08_from_scratch_macro_add
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
