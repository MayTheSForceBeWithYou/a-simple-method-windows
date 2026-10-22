; 13-hashmap-put-get
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_13_hashmap_put_get:PROC
main PROC
    ; TODO: write ex_13_hashmap_put_get in this file.
    call    ex_13_hashmap_put_get
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
