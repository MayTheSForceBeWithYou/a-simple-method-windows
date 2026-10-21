; Listing 18: LESSON.md asm block 18
; Expected exit: 0
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC
main PROC
    mov ecx, 0
    call ExitProcess
main ENDP
END
