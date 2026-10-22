; 06-hash-cell: hash cell
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_06_hash_cell:PROC
main PROC
    ; TODO: implement ex_06_hash_cell (student routine; defined in solutions/).
    call    ex_06_hash_cell
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
