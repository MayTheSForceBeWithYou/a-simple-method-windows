; Exercise 19: matrix index
;
; Row-major 3x3; get (r=1,c=2) from 1..9 matrix -> 6.
;
; Expected exit: 6
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
m QWORD 1,2,3,4,5,6,7,8,9

.code
ex_19_matrix_index PROC
    sub rsp, 40
    mov rax, 1
    imul rax, 3
    add rax, 2
    lea r11, [m]
        mov     eax, QWORD PTR [r11+rax*8]
    add     rsp, 40
    ret
ex_19_matrix_index ENDP
main PROC
    call    ex_19_matrix_index
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
