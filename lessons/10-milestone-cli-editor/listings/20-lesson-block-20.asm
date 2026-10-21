; Listing 20: LESSON.md asm block 20
; Expected exit: 0
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC
main PROC
    mov ecx, 0
    call ExitProcess
main ENDP
END
