; 01-q16-encode.asm: Encode integers in Q16.16 format
; 5 << 16 = 0x50000, then >> 16 = 5, exit 5
.CODE
EXTRN ExitProcess:PROC
main PROC
    mov eax, 5
    shl eax, 16
    sar eax, 16
    mov ecx, eax
    call ExitProcess
main ENDP
END
