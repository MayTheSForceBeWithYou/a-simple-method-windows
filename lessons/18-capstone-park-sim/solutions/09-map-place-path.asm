; Exercise 09: map place path
;
; Place PATH=1 at (2,3) on w=8; index=3*8+2=26; store; exit cell.
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

PATH EQU 1

.data?
map BYTE 256 DUP(0)

.code
main PROC
    sub rsp, 40
    mov rax, 3
    imul rax, 8
    add rax, 2
    mov BYTE PTR [map+rax], PATH
    movzx rcx, BYTE PTR [map+rax]
    call ExitProcess
main ENDP
END
