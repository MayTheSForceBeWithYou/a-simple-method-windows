; Exercise 08: two writes
;
; Write "alpha\n" then "beta\n" with two write syscalls. Exit 0.
;
; Build: ml64 /c 08-two-writes.asm && link /OUT:08-two-writes.exe /ENTRY:main /SUBSYSTEM:CONSOLE 08-two-writes.obj kernel32.lib
;
; Expected exit: 0

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

.data
a BYTE "alpha", 13, 10
a_len EQU $ - a
b BYTE "beta", 13, 10
b_len EQU $ - b

.data?
written DWORD ?
hStdOut QWORD ?

.code
ex_08_two_writes PROC
    sub rsp, 56
    
    ; Get stdout handle
    mov rcx, -11
    call GetStdHandle
    mov hStdOut, rax
    
    ; Write "alpha\n"
    mov rcx, hStdOut
    lea rdx, a
    mov r8d, a_len
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Write "beta\n"
    mov rcx, hStdOut
    lea rdx, b
    mov r8d, b_len
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 0
        mov     eax, 0
    add     rsp, 56
    ret
ex_08_two_writes ENDP
main PROC
    sub     rsp, 40
    call    ex_08_two_writes
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
