; 11-fixed-div.asm: Q16.16 division, exit result
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_11_fixed_div:PROC
main PROC
    ; TODO: implement ex_11_fixed_div (student routine; defined in solutions/).
    call    ex_11_fixed_div
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
