; 09-q16-from-int.asm: Encode 5 in Q16.16, decode, exit 5
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_09_q16_from_int:PROC
main PROC
    ; TODO: implement ex_09_q16_from_int (student routine; defined in solutions/).
    call    ex_09_q16_from_int
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
