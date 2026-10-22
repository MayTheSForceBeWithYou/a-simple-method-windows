; Exercise: 14-tile-collision-mask
;
; Flags bit0 solid bit1 platform; value 3; exit solid&1 =1.
; Expected stdout: (none)
; Expected exit: 1
;
.data
flags BYTE 3

.code
ex_14_tile_collision_mask PROC
    sub rsp, 40
    movzx rcx, BYTE PTR [flags]
    and rcx, 1
    mov     eax, ecx
    add     rsp, 40
    ret
ex_14_tile_collision_mask ENDP
main PROC
    sub     rsp, 40
    call    ex_14_tile_collision_mask
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
