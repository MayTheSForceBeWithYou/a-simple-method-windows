; 21-debug-macro-arity.asm
; Fix: EXIT_STATUS 4 (supply missing argument).
; Expected exit: 4

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_debug_macro_arity:PROC

EXIT_STATUS MACRO code
    mov ecx, code
    call ExitProcess
ENDM

main PROC
    sub     rsp, 40
    ; BUG: should exit 4 via EXIT_STATUS 4 inside ex_21_debug_macro_arity
    mov     ecx, 0
    ; TODO: write ex_21_debug_macro_arity in this file.
    call    ex_21_debug_macro_arity
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
