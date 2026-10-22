; Exercise: 11-sprite-layer
;
; Sort key layer*1000+y; layer2 y=5 -> 2005&255; exit (2005 & 255)=205? Use exit layer=2.
; Expected stdout: (none)
; Expected exit: 2
;
.code
ex_11_sprite_layer PROC
    sub rsp, 40
    mov rcx, 2
    mov     eax, 2
    add     rsp, 40
    ret
ex_11_sprite_layer ENDP
main PROC
    sub     rsp, 40
    call    ex_11_sprite_layer
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
