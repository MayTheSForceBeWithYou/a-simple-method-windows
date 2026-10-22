; Exercise: 18-input-queue
;
; Enqueue event 9; dequeue; exit 9.
; Expected stdout: (none)
; Expected exit: 9
;
.data?
q QWORD 4 DUP(?)
h QWORD ?
t QWORD ?

.code
ex_18_input_queue PROC
    sub rsp, 40
    mov rcx, [t]
    lea r11, [q]
    mov QWORD PTR [r11+rcx*8], 9
    inc QWORD PTR [t]
    mov rcx, [h]
    lea r11, [q]
    mov rcx, [r11+rcx*8]
    inc QWORD PTR [h]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_18_input_queue ENDP
main PROC
    sub     rsp, 40
    call    ex_18_input_queue
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
