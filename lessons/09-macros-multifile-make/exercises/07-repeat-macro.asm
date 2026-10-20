; 07-repeat-macro.asm
; Use REPT to generate three INC instructions, exit 3.
; Task: xor eax; REPT 3; inc eax; ENDM; exit eax.

.CODE
EXTRN ExitProcess:PROC

main PROC
    xor eax, eax
    ; TODO: REPT 3; inc eax; ENDM
    .ERR <TODO: Use REPT to generate three inc eax>
    mov ecx, eax
    call ExitProcess
main ENDP
END
