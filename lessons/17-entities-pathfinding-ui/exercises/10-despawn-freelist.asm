; 10-despawn-freelist: despawn freelist
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_10_despawn_freelist:PROC
main PROC
    ; TODO: write ex_10_despawn_freelist in this file.
    call    ex_10_despawn_freelist
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
