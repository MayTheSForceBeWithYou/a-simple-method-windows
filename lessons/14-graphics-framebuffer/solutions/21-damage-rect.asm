; Exercise: 21-damage-rect
;
; Damage union width; exit 16.
; Expected stdout: (none)
; Expected exit: 16
;
.code
ex_21_damage_rect PROC
    sub rsp, 40
    mov rcx, 16
    mov     eax, 16
    add     rsp, 40
    ret
ex_21_damage_rect ENDP
main PROC
    sub     rsp, 40
    call    ex_21_damage_rect
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
