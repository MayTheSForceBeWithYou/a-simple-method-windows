; 17-flip-flags: flip flags
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_17_flip_flags:PROC
main PROC
    ; TODO: write ex_17_flip_flags in this file.
    call    ex_17_flip_flags
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
