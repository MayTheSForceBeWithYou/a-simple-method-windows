; Exercise 24: overwrite data
;
; msg BYTE 'x',CR,LF. Change first byte to 'Y' in place, write 3 bytes, exit 0.
;
; Build: ml64 /c 24-overwrite-data.asm && link /OUT:24-overwrite-data.exe /ENTRY:main /SUBSYSTEM:CONSOLE 24-overwrite-data.obj kernel32.lib
;
; Expected exit: 0

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

.data
msg BYTE "x", 13, 10

.data?
written DWORD ?
hStdOut QWORD ?

.code
ex_24_overwrite_data PROC
    sub rsp, 56
    
    ; Overwrite first byte
    mov BYTE PTR [msg], 'Y'
    
    ; Get stdout handle
    mov rcx, -11
    call GetStdHandle
    mov hStdOut, rax
    
    ; Write message
    mov rcx, hStdOut
    lea rdx, msg
    mov r8d, 3
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 0
    mov rcx, 0
    mov     eax, 0
    add     rsp, 56
    ret
ex_24_overwrite_data ENDP
main PROC
    sub     rsp, 40
    call    ex_24_overwrite_data
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
