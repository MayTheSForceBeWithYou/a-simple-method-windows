; Listing 07: DEBUG EQU and IFDEF exit branch (LESSON.md block 7)
;
; Purpose: Conditional assembly picks exit code when DEBUG is defined.
; Expected exit: 1
; Expected stdout: (none)

DEBUG EQU 1

.CODE
EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 32
    .allocstack 32
    .endprolog
    IFDEF DEBUG
        mov ecx, 1
    ELSE
        xor ecx, ecx
    ENDIF
    call ExitProcess
main ENDP

END
