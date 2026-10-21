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

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
