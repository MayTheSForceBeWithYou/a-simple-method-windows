; Exercise: 21-formation-slot
;
; Slot index 2 offset; exit 2.
; Expected stdout: (none)
; Expected exit: 2
;
.code
ex_21_formation_slot PROC
    sub rsp, 40
    mov rcx, 2
    mov     eax, 2
    add     rsp, 40
    ret
ex_21_formation_slot ENDP
main PROC
    sub     rsp, 40
    call    ex_21_formation_slot
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
