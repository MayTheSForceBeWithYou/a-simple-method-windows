; 21-debug-macro-arity.asm
; Fix: EXIT_STATUS 4 (supply missing argument).

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_debug_macro_arity:PROC

; Macro expecting one argument
ExitStatus MACRO status
    mov ecx, status
    call ExitProcess
ENDM

main PROC
    ; TODO: Fix invocation: ExitStatus 4
    ; TODO: write ex_21_debug_macro_arity in this file.
    call    ex_21_debug_macro_arity
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
