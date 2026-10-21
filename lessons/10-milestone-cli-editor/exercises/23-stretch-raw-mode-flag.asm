; 23-stretch-raw-mode-flag.asm: Track console mode (raw=1), exit raw
.DATA?
raw_mode QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    mov raw_mode, 0

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
