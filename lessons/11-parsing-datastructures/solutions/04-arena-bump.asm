; Exercise 04: arena bump
;
; Bump allocate 16 then 16; offset 32; exit 32&255.
; Expected exit: 32

EXTERN ExitProcess:PROC

.data?
bump QWORD ?

.code
main PROC
    sub rsp, 32
    mov QWORD PTR [bump], 0
    add QWORD PTR [bump], 16
    add QWORD PTR [bump], 16
    mov rcx, QWORD PTR [bump]
    and rcx, 255
    call ExitProcess
main ENDP
END
