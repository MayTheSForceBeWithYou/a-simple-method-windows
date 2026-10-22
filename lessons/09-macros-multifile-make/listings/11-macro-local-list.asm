; Listing 11: LOCAL label list in a macro (LESSON.md block 11)
;
; Purpose: Declare multiple LOCAL symbols; body increments a register once per expansion.
; Expected exit: 2
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

MACRO_NAME MACRO
    LOCAL label1, label2, label3
    inc rcx
ENDM

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    xor rcx, rcx
    MACRO_NAME
    MACRO_NAME
    mov ecx, 2
    call ExitProcess
main ENDP

END
