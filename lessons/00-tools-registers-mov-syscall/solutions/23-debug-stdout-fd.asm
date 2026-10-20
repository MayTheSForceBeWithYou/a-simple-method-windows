; Exercise 23: debug stdout fd
;
; BUG HUNT: handle is wrong. Fix to stdout.
;
; Build: ml64 /c 23-debug-stdout-fd.asm && link /OUT:23-debug-stdout-fd.exe /ENTRY:main /SUBSYSTEM:CONSOLE 23-debug-stdout-fd.obj kernel32.lib
;
; Expected exit: 0

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

.data
msg BYTE "visible", 13, 10
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
