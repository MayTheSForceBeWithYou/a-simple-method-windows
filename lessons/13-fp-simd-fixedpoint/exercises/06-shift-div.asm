; 06-shift-div.asm: Fixed-point div: shift left 16, divide, exit
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_06_shift_div:PROC
main PROC
    ; TODO: implement ex_06_shift_div (student routine; defined in solutions/).
    call    ex_06_shift_div
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
