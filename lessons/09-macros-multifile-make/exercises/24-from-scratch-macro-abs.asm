; 24-from-scratch-macro-abs.asm (from scratch)
; ABS macro with LOCAL label, exit 9.

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_24_from_scratch_macro_abs:PROC

; TODO: AbsVal MACRO reg; LOCAL skip; cmp reg, 0; jge skip; neg reg; skip:; ENDM

main PROC
    sub     rsp, 40
    ; TODO: write ex_24_from_scratch_macro_abs in this file.
    call    ex_24_from_scratch_macro_abs
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
