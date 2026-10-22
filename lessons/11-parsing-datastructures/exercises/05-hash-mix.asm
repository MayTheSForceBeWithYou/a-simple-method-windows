; 05-hash-mix
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_05_hash_mix:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_05_hash_mix in this file.
    call    ex_05_hash_mix
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
