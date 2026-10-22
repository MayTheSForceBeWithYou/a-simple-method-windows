; Exercise: 23-stretch-multiplayer-stub
;
; STRETCH: net tick id 2; exit 2. (local stub)
; Expected stdout: (none)
; Expected exit: 2
;
.data
tick_id QWORD 0

.code
ex_23_stretch_multiplayer_stub PROC
    sub rsp, 40
    mov QWORD PTR [tick_id], 2
    mov rcx, QWORD PTR [tick_id]
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
