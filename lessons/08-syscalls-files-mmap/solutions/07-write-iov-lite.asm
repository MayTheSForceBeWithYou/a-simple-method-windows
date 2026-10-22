; Exercise: 07-write-iov-lite
;
; Two writes simulating writev; print 'A\nB\n'; exit 0.
; Expected stdout: "A\nB\n"
; Expected exit: 0
;
.data
a BYTE "A", 10
b BYTE "B", 10

.data?
written DWORD ?
hStdOut QWORD ?

.code
ex_07_write_iov_lite PROC
    sub rsp, 56
    
    ; Get stdout handle
    mov rcx, -11
    call GetStdHandle
    mov hStdOut, rax
    
    ; Write first message
    mov rcx, hStdOut
    lea rdx, a
    mov r8d, 2
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Write second message
    mov rcx, hStdOut
    lea rdx, b
    mov r8d, 2
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 0
    mov rcx, 0
    mov     eax, 0
    add     rsp, 56
    ret
ex_07_write_iov_lite ENDP
main PROC
    sub     rsp, 40
    call    ex_07_write_iov_lite
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
