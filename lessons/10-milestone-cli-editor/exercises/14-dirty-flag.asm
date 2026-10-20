; 14-dirty-flag.asm: Set dirty=1 on edit, clear on save, exit dirty
.DATA?
dirty QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    mov dirty, 0
    .ERR <TODO: Simulate edit (set dirty=1), simulate save (clear dirty=0), exit dirty>
main ENDP
END
