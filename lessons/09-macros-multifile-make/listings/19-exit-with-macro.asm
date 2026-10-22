; Listing 19: EXIT_WITH macro after add_two_numbers (LESSON.md block 19)
;
; Expected exit: 42
; Expected stdout: (none)
;
; ml64 /c 20-add-two-numbers.asm && ml64 /c 19-exit-with-macro.asm && link ...

.CODE
EXTRN add_two_numbers:PROC
EXTRN ExitProcess:PROC

EXIT_WITH MACRO code
    mov rcx, code
    call ExitProcess
ENDM

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    mov rcx, 20
    mov rdx, 22
    call add_two_numbers
    EXIT_WITH rax
main ENDP

END
