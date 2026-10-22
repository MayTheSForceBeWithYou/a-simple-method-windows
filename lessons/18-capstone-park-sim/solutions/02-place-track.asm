; Exercise: 02-place-track
;
; Track piece type 3; exit 3.
; Expected stdout: (none)
; Expected exit: 3
;
.code
ex_02_place_track PROC
    sub rsp, 40
    mov rcx, 3
    mov     eax, 3
    add     rsp, 40
    ret
ex_02_place_track ENDP
main PROC
    sub     rsp, 40
    call    ex_02_place_track
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
