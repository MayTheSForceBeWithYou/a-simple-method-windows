; Exercise 15: rip relative
;
; Use lea rdx,[msg] (RIP-relative by default in MASM x64) to write msg 'rip\n'. Exit 0.
;
; Build: ml64 /c 15-rip-relative.asm && link /OUT:15-rip-relative.exe /ENTRY:main /SUBSYSTEM:CONSOLE 15-rip-relative.obj kernel32.lib
;
; Expected exit: 0

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

.data
msg BYTE "rip", 13, 10
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
    
    ; Write message (RIP-relative addressing)
    mov rcx, hStdOut
    lea rdx, [msg]
    mov r8d, msg_len
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 0
    mov rcx, 0
    call ExitProcess
main ENDP
END
