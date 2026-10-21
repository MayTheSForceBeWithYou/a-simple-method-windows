; Listing 18: LESSON.md asm block 18
; Expected exit: 1
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC
main PROC
    mov ecx, 1
    call ExitProcess
main ENDP
END
