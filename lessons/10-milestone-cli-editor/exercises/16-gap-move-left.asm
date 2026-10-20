; 16-gap-move-left.asm: Move gap left (copy byte to gap_end-1, dec both), exit gap_start
.DATA?
buf DB 256 DUP(?)
gap_start QWORD ?
gap_end QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    mov buf[0], 'X'
    mov gap_start, 1
    mov gap_end, 256
    .ERR <TODO: Move gap left: dec gap_start, dec gap_end, copy buf[gap_start] to buf[gap_end], exit gap_start>
main ENDP
END
