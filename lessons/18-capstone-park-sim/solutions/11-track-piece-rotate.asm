; Exercise 11: track piece rotate
;
; Rotate piece dir 0..3; 3+1 -> 0; exit 0.
;
; Expected exit: 0
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
dir QWORD 0

.code
main PROC
    sub rsp, 40
    mov QWORD PTR [dir], 3
    inc QWORD PTR [dir]
    mov rax, QWORD PTR [dir]
    and rax, 3
    mov QWORD PTR [dir], rax
    mov rcx, rax
    call ExitProcess
main ENDP
END
