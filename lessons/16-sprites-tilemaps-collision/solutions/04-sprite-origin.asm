; Exercise: 04-sprite-origin
;
; screen = world - camera; 50-20=30.
; Expected stdout: (none)
; Expected exit: 30
;
.code
ex_04_sprite_origin PROC
    sub rsp, 40
    mov rcx, 50
    sub rcx, 20
    mov     eax, ecx
    add     rsp, 40
    ret
ex_04_sprite_origin ENDP
main PROC
    sub     rsp, 40
    call    ex_04_sprite_origin
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
