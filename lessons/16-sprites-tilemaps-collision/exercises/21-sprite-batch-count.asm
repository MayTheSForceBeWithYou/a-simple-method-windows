; Exercise: 21-sprite-batch-count
;
; Exercise 21: sprite batch count
; Batch 8 sprites; exit 8.
; Expected stdout: (none)
;
; Contract: implement `ex_21_sprite_batch_count` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 8
;

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
