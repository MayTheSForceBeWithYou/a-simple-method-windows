; Exercise 27: stretch sys write regs
;
; Print "syscall\n" using write API. Exit 0.
;
; Build: ml64 /c 27-stretch-sys-write-regs.asm && link /OUT:27-stretch-sys-write-regs.exe /ENTRY:main /SUBSYSTEM:CONSOLE 27-stretch-sys-write-regs.obj kernel32.lib
;
; Expected exit: 0

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

.data
msg BYTE "syscall", 13, 10
msg_len EQU $ - msg

.data?
written DWORD ?
hStdOut QWORD ?

.code
main PROC
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
    call ExitProcess
main ENDP
END
