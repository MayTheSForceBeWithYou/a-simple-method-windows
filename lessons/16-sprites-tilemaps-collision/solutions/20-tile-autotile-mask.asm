; Exercise: 20-tile-autotile-mask
;
; Neighbor mask N|E = 5; exit 5.
; Expected stdout: (none)
; Expected exit: 5
;
.code
ex_20_tile_autotile_mask PROC
    sub rsp, 40
    mov rcx, N
    or rcx, E
    mov     eax, ecx
    add     rsp, 40
    ret
ex_20_tile_autotile_mask ENDP
main PROC
    sub     rsp, 40
    call    ex_20_tile_autotile_mask
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
