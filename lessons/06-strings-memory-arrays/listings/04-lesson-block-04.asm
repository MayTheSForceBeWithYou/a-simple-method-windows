; Listing 04: LESSON.md asm block 4
; Expected exit: 0
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC
main PROC
    xor ecx, ecx
    call ExitProcess
main ENDP
END
