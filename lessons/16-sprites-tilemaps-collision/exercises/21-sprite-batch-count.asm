; 21-sprite-batch-count: sprite batch count
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_sprite_batch_count:PROC
main PROC
    ; TODO: implement ex_21_sprite_batch_count (student routine; defined in solutions/).
    call    ex_21_sprite_batch_count
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
