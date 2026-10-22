; Exercise 04: arena bump
;
; Bump allocate 16 then 16; offset 32; exit 32&255.
; Expected exit: 32

EXTERN ExitProcess:PROC

.data?
bump QWORD ?

.code

ex_04_arena_bump PROC
sub rsp, 40
    mov QWORD PTR [bump], 0
    add QWORD PTR [bump], 16
    add QWORD PTR [bump], 16
    mov rcx, QWORD PTR [bump]
    and rcx, 255
    mov     eax, 32
    ret
ex_04_arena_bump ENDP
main PROC
    sub     rsp, 40
    call    ex_04_arena_bump
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
