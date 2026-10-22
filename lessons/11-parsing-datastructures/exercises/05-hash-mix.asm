; 05-hash-mix
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_05_hash_mix:PROC
main PROC
    ; TODO: implement ex_05_hash_mix (student routine; defined in solutions/).
    call    ex_05_hash_mix
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
