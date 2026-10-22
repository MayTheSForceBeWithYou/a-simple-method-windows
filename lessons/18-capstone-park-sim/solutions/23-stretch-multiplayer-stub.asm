; Exercise 23: stretch multiplayer stub
;
; STRETCH: net tick id 2; exit 2. (local stub)
;
; Expected exit: 2
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
tick_id QWORD 0

.code
ex_23_stretch_multiplayer_stub PROC
    sub rsp, 40
    mov QWORD PTR [tick_id], 2
        mov     eax, ecx
    add     rsp, 40
    ret
ex_23_stretch_multiplayer_stub ENDP
main PROC
    sub     rsp, 40
    call    ex_23_stretch_multiplayer_stub
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
