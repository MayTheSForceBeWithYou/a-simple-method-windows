; Exercise: 21-sprite-batch-count
;
; Batch 8 sprites; exit 8.
; Expected stdout: (none)
; Expected exit: 8
;
.code
ex_21_sprite_batch_count PROC
    sub rsp, 40
    mov rcx, 8
    mov     eax, 8
    add     rsp, 40
    ret
ex_21_sprite_batch_count ENDP
main PROC
    sub     rsp, 40
    call    ex_21_sprite_batch_count
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
