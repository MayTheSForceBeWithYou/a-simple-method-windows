; Exercise 20: label addresses
;
; Two messages; print only msg2 "use me\n". Exit 0.
;
; Build: ml64 /c 20-label-addresses.asm && link /OUT:20-label-addresses.exe /ENTRY:main /SUBSYSTEM:CONSOLE 20-label-addresses.obj kernel32.lib
;
; Expected exit: 0

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

.data
msg1 BYTE "skip", 13, 10
msg2 BYTE "use me", 13, 10
msg2_len EQU $ - msg2

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
    
    ; Write msg2
    mov rcx, hStdOut
    lea rdx, msg2
    mov r8d, msg2_len
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 0
    mov rcx, 0
    call ExitProcess
main ENDP
END
