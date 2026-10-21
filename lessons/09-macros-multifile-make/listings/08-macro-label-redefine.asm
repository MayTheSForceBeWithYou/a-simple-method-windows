; Listing 08: Macro without LOCAL reuses label (LESSON.md block 8)
;
; Purpose: One expansion works; a second TWICE in the same file would fail ml64 (A2005).
; Expected exit: 1
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

TWICE MACRO
skip_label:
    inc rdi
ENDM

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    xor rdi, rdi
    TWICE
    mov ecx, edi
    call ExitProcess
main ENDP

END
