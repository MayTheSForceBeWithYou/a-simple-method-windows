; 20-macro-with-params.asm
; ADD3 macro: ADD3 10, 20, 12; exit 42.

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_macro_with_params:PROC

; TODO: ADD3 MACRO reg, v1, v2, v3; mov reg, v1; add reg, v2; add reg, v3; ENDM

main PROC
    ; TODO: ADD3 rax, 10, 20, 12
    ; TODO: implement ex_20_macro_with_params (student routine; defined in solutions/).
    call    ex_20_macro_with_params
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
