; 12-strstr-macro-label.asm
; TWICE macro with two INC, no label collision, exit 2.

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_12_strstr_macro_label:PROC

; TODO: TWICE MACRO; inc rax; inc rax; ENDM (no labels needed)

main PROC
    sub     rsp, 40
    ; TODO: write ex_12_strstr_macro_label in this file.
    call    ex_12_strstr_macro_label
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
