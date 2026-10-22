; 11-fixed-div.asm: Q16.16 division, exit result
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_11_fixed_div:PROC
main PROC
    ; TODO: write ex_11_fixed_div in this file.
    call    ex_11_fixed_div
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
