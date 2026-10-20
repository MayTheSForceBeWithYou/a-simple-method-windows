; Exercise 09: write len check
;
; write "Z\n"; if written==2 exit 0 else 1.
;
; Build: ml64 /c 09-write-len-check.asm && link /OUT:09-write-len-check.exe /ENTRY:main /SUBSYSTEM:CONSOLE 09-write-len-check.obj kernel32.lib
;
; Expected exit: 0
; Expected stdout: "Z\n"

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

.data
msg BYTE "Z", 10

.data?
written DWORD ?

.code
main PROC
    sub rsp, 56
    
    ; Get stdout handle
    mov rcx, -11
    call GetStdHandle
    
    ; Write message
    mov rcx, rax
    lea rdx, msg
    mov r8d, 2
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Check if 2 bytes were written
    cmp written, 2
    jne .bad
    
    ; Success - exit 0
    mov rcx, 0
    jmp .o
    
.bad:
    ; Failure - exit 1
    mov rcx, 1
    
.o:
    call ExitProcess
main ENDP
END
