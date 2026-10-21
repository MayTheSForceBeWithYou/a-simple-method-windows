; Listing 06: LESSON.md asm block 6
; Expected exit: 0
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC
main PROC
    mov ecx, 0
    call ExitProcess
main ENDP
END
