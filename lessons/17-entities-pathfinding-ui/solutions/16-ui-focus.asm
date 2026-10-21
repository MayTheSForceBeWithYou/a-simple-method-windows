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
main PROC
    sub rsp, 40
    mov QWORD PTR [focus], 2
    inc QWORD PTR [focus]
    mov rax, QWORD PTR [focus]
    xor rdx, rdx
    mov r8, 3
    div r8
    mov QWORD PTR [focus], rdx
    mov rcx, rdx
    call ExitProcess
main ENDP
END
