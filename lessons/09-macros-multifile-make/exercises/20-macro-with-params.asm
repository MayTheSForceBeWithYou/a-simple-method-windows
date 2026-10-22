; 20-macro-with-params.asm
; ADD3 macro: ADD3 10, 20, 12; exit 42.

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_macro_with_params:PROC

; TODO: ADD3 MACRO reg, v1, v2, v3; mov reg, v1; add reg, v2; add reg, v3; ENDM

main PROC
    sub     rsp, 40
    ; TODO: ADD3 rax, 10, 20, 12
    ; TODO: write ex_20_macro_with_params in this file.
    call    ex_20_macro_with_params
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
