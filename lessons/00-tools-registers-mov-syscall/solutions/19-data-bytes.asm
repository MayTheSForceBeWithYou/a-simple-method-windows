; Exercise 19: data bytes
;
; Emit bytes 0x48 0x69 0x0A (Hi newline) using BYTE. Write them; exit 0.
;
; Build: ml64 /c 19-data-bytes.asm && link /OUT:19-data-bytes.exe /ENTRY:main /SUBSYSTEM:CONSOLE 19-data-bytes.obj kernel32.lib
;
; Expected exit: 0

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

.data
msg BYTE 048h, 069h, 00Dh, 00Ah
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
