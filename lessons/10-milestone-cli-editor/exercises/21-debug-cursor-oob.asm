; 21-debug-cursor-oob.asm: Clamp out-of-range cursor, exit clamped value
.DATA?
len QWORD ?
cur QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    mov len, 3
    mov cur, 9
    .ERR <TODO: Clamp cur to [0, len], exit cur (should be 3)>
main ENDP
END
