; Exercise 12: debug clobber rax
;
; BUG HUNT: Should write "X\n" then exit 0. Register set wrong before write. Fix.
;
; Build: ml64 /c 12-debug-clobber-rax.asm && link /OUT:12-debug-clobber-rax.exe /ENTRY:main /SUBSYSTEM:CONSOLE 12-debug-clobber-rax.obj kernel32.lib
;
; Expected exit: 0

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

.data
msg BYTE "X", 13, 10
msg_len EQU $ - msg

.data?
written DWORD ?
hStdOut QWORD ?

.code
ex_12_debug_clobber_rax PROC
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
ex_12_debug_clobber_rax ENDP
main PROC
    sub     rsp, 40
    call    ex_12_debug_clobber_rax
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
