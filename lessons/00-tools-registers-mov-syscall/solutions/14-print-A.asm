; Exercise 14: print A
;
; Write "A\n". Exit 0.
;
; Build: ml64 /c 14-print-A.asm && link /OUT:14-print-A.exe /ENTRY:main /SUBSYSTEM:CONSOLE 14-print-A.obj kernel32.lib
;
; Expected exit: 0

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

.data
msg BYTE "A", 13, 10
msg_len EQU $ - msg

.data?
written DWORD ?
hStdOut QWORD ?

.code
ex_14_print_A PROC
    sub rsp, 56
    
    ; Get stdout handle
    mov rcx, -11
    call GetStdHandle
    mov hStdOut, rax
    
    ; Write message
    mov rcx, hStdOut
    lea rdx, msg
    mov r8d, msg_len
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 0
    mov rcx, 0
    mov     eax, 0
    add     rsp, 56
    ret
ex_14_print_A ENDP
main PROC
    sub     rsp, 40
    call    ex_14_print_A
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
