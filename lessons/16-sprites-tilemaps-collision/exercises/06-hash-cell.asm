; 06-hash-cell: hash cell
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_06_hash_cell:PROC
main PROC
    ; TODO: write ex_06_hash_cell in this file.
    call    ex_06_hash_cell
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
