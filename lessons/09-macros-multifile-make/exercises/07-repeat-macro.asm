; 07-repeat-macro.asm
; Use REPT to generate three INC instructions, exit 3.
; Task: xor eax; REPT 3; inc eax; ENDM; exit eax.

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_07_repeat_macro:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_07_repeat_macro (student routine; defined in solutions/).
    call    ex_07_repeat_macro
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
