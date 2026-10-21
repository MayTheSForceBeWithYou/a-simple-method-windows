; Listing 09: LESSON.md asm block 9
; Expected exit: 0
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC
main PROC
    xor ecx, ecx
    call ExitProcess
main ENDP
END
