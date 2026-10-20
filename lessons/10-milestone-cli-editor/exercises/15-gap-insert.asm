; 15-gap-insert.asm: Insert in gap buffer (store at gap_start, inc gap_start), exit gap_start
.DATA?
buf DB 256 DUP(?)
gap_start QWORD ?
gap_end QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    mov gap_start, 0
    mov gap_end, 256
    .ERR <TODO: Store 'G' at buf[gap_start], inc gap_start, exit gap_start>
main ENDP
END
