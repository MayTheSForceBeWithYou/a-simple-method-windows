; 16-repeat-delay: repeat delay
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_16_repeat_delay:PROC
main PROC
    ; TODO: implement ex_16_repeat_delay (student routine; defined in solutions/).
    call    ex_16_repeat_delay
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
