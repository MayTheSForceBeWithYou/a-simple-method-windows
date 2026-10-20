; 03-cursor-move.asm: Move cursor right with clamping, exit cursor value
.DATA?
len QWORD ?
cur QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    mov len, 3
    mov cur, 2
    .ERR <TODO: inc cur; cmp cur with len; clamp if needed; exit cur>
main ENDP
END
