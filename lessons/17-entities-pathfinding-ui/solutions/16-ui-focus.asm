; Exercise 16: ui focus
;
; Tab cycles focus index mod 3; from 2 -> 0; exit 0.
;
; Expected exit: 0
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
focus QWORD 0

.code
ex_16_ui_focus PROC
    sub rsp, 40
    mov QWORD PTR [focus], 2
    inc QWORD PTR [focus]
    mov rax, QWORD PTR [focus]
    xor rdx, rdx
    mov r8, 3
    div r8
    mov QWORD PTR [focus], rdx
        mov     eax, rdx
    ret

ex_16_ui_focus ENDP
main PROC
    call    ex_16_ui_focus
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
