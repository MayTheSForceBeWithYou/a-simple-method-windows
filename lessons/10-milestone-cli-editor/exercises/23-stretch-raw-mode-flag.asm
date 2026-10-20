; 23-stretch-raw-mode-flag.asm: Track console mode (raw=1), exit raw
.DATA?
raw_mode QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    mov raw_mode, 0
    .ERR <TODO: Set raw_mode=1 (simulate entering raw mode), exit raw_mode>
main ENDP
END
