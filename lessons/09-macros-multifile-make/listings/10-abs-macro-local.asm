; Listing 10: ABS macro with LOCAL ok_label (LESSON.md block 10)
;
; Purpose: Absolute value via compare/neg with a unique branch label per expansion.
; Expected exit: 9
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

ABS MACRO reg
    LOCAL ok_label
    cmp reg, 0
    jge ok_label
    neg reg
ok_label:
ENDM

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    mov rdi, -9
    ABS rdi
    mov ecx, edi
    call ExitProcess
main ENDP

END
