; 17-flip-flags: flip flags
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_17_flip_flags:PROC
main PROC
    ; TODO: implement ex_17_flip_flags (student routine; defined in solutions/).
    call    ex_17_flip_flags
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
