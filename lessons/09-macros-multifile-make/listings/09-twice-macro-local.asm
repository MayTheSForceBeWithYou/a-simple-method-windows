; Listing 09: TWICE macro with LOCAL labels (LESSON.md block 9)
;
; Purpose: Each macro expansion gets a unique label; two calls increment rdi twice.
; Expected exit: 2
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

TWICE MACRO
    LOCAL skip_label
skip_label:
    inc rdi
ENDM

main PROC FRAME
    sub rsp, 32
    .allocstack 32
    .endprolog
    xor rdi, rdi
    TWICE
    TWICE
    mov ecx, edi
    call ExitProcess
main ENDP

END
