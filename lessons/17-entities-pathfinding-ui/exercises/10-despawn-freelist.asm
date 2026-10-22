; 10-despawn-freelist: despawn freelist
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_10_despawn_freelist:PROC
main PROC
    ; TODO: implement ex_10_despawn_freelist (student routine; defined in solutions/).
    call    ex_10_despawn_freelist
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
