; 21-debug-macro-arity.asm
; Fix: EXIT_STATUS 4 (supply missing argument).

.CODE
EXTRN ExitProcess:PROC

; Macro expecting one argument
ExitStatus MACRO status
    mov ecx, status
    call ExitProcess
ENDM

main PROC
    ; TODO: Fix invocation: ExitStatus 4
main ENDP
END
