; Exercise 09: write stderr
;
; Write "error\n" to stderr (fd 2), exit 1.
;
; Build: ml64 /c 09-write-stderr.asm && link /OUT:09-write-stderr.exe /ENTRY:main /SUBSYSTEM:CONSOLE 09-write-stderr.obj kernel32.lib
;
; Expected exit: 1

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

.data
msg BYTE "error", 13, 10
msg_len EQU $ - msg

.data?
written DWORD ?
hStdErr QWORD ?

.code
ex_09_write_stderr PROC
    sub rsp, 56
    
    ; Get stderr handle
    mov rcx, -12
    call GetStdHandle
    mov hStdErr, rax
    
    ; Write message
    mov rcx, hStdErr
    lea rdx, msg
    mov r8d, msg_len
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 1
        mov     eax, 1
    add     rsp, 56
    ret
ex_09_write_stderr ENDP
main PROC
    sub     rsp, 40
    call    ex_09_write_stderr
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
