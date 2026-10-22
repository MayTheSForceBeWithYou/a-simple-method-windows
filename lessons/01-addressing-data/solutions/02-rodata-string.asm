; Exercise 02: rodata string
;
; Put "rodata\n" in .const (read-only data), write it, exit 0.
;
; Build: ml64 /c 02-rodata-string.asm && link /OUT:02-rodata-string.exe /ENTRY:main /SUBSYSTEM:CONSOLE 02-rodata-string.obj kernel32.lib
;
; Expected exit: 0

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

.const
msg BYTE "rodata", 13, 10
msg_len EQU $ - msg

.data?
written DWORD ?
hStdOut QWORD ?

.code
ex_02_rodata_string PROC
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
ex_02_rodata_string ENDP
main PROC
    sub     rsp, 40
    call    ex_02_rodata_string
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
