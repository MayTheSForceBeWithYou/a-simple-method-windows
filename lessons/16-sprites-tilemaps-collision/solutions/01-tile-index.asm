; Exercise: 01-tile-index
;
; idx=y*map_w+x; y=2 x=3 w=10; exit 23.
; Expected stdout: (none)
; Expected exit: 23
;
.code
ex_01_tile_index PROC
    sub rsp, 40
    mov rax, 2
    imul rax, 10
    add rax, 3
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_01_tile_index ENDP
main PROC
    sub     rsp, 40
    call    ex_01_tile_index
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
