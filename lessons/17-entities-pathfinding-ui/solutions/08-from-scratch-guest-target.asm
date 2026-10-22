; Exercise: 08-from-scratch-guest-target
;
; FROM SCRATCH: guest target id 7; exit 7.
; Expected stdout: (none)
; Expected exit: 7
;
.code
ex_08_from_scratch_guest_target PROC
    sub rsp, 40
    mov rcx, 7
    mov     eax, 7
    add     rsp, 40
    ret
ex_08_from_scratch_guest_target ENDP
main PROC
    sub     rsp, 40
    call    ex_08_from_scratch_guest_target
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
