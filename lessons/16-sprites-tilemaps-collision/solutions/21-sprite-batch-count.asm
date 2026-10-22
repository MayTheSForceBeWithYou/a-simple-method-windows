; Exercise 21: sprite batch count
;
; Batch 8 sprites; exit 8.
;
; Build: ml64 /c 21-sprite-batch-count.asm && link /OUT:21-sprite-batch-count.exe /ENTRY:main /SUBSYSTEM:CONSOLE 21-sprite-batch-count.obj kernel32.lib
;
; Expected exit: 8
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_21_sprite_batch_count PROC
    sub rsp, 40
        mov     eax, 8
    add     rsp, 40
    ret
ex_21_sprite_batch_count ENDP
main PROC
    call    ex_21_sprite_batch_count
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
