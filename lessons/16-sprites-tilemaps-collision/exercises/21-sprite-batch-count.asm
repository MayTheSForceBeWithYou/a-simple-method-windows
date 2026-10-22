; 21-sprite-batch-count: sprite batch count
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_sprite_batch_count:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_21_sprite_batch_count in this file.
    call    ex_21_sprite_batch_count
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
