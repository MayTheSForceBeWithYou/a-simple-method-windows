; 18-spatial-hash-insert: spatial hash insert
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_18_spatial_hash_insert:PROC
main PROC
    ; TODO: write ex_18_spatial_hash_insert in this file.
    call    ex_18_spatial_hash_insert
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
