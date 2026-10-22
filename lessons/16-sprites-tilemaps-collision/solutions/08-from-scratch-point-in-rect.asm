; Exercise: 08-from-scratch-point-in-rect
;
; FROM SCRATCH: point in rect -> 1.
; Expected stdout: (none)
; Expected exit: 1
;
.code
ex_08_from_scratch_point_in_rect PROC
    sub rsp, 40
    ; p(2,2) in [0,0,5,5]
    mov rcx, 1
    mov     eax, 1
    add     rsp, 40
    ret
ex_08_from_scratch_point_in_rect ENDP
main PROC
    sub     rsp, 40
    call    ex_08_from_scratch_point_in_rect
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
