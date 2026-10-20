; Exercise 26: two exits dead
;
; Write "alive\n", exit 0, then dead exit 99 after (unreachable).
;
; Build: ml64 /c 26-two-exits-dead.asm && link /OUT:26-two-exits-dead.exe /ENTRY:main /SUBSYSTEM:CONSOLE 26-two-exits-dead.obj kernel32.lib
;
; Expected exit: 0

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

.data
msg BYTE "alive", 13, 10
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
    
    ; Dead code (unreachable)
    mov rcx, 99
    call ExitProcess
main ENDP
END
