; Exercise: 10-world-to-tile
;
; world x=20 tile_size=8 -> tile 2; exit 2.
; Expected stdout: (none)
; Expected exit: 2
;
.code
ex_10_world_to_tile PROC
    sub rsp, 40
    mov rax, 20
    shr rax, 3
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_10_world_to_tile ENDP
main PROC
    sub     rsp, 40
    call    ex_10_world_to_tile
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
