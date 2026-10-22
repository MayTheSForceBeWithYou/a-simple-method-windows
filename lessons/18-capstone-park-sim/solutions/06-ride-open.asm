; Exercise: 06-ride-open
;
; flag open=1; exit 1.
; Expected stdout: (none)
; Expected exit: 1
;
.data?
open BYTE ?

.code
ex_06_ride_open PROC
    sub rsp, 40
    mov BYTE PTR [open], 1
    movzx rcx, BYTE PTR [open]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_06_ride_open ENDP
main PROC
    sub     rsp, 40
    call    ex_06_ride_open
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
