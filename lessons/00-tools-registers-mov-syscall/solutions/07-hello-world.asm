; Exercise 07: hello world
;
; Write "Hello, world\n" to stdout, then exit 0.
;
; Build: ml64 /c 07-hello-world.asm && link /OUT:07-hello-world.exe /ENTRY:main /SUBSYSTEM:CONSOLE 07-hello-world.obj kernel32.lib
;
; Expected exit: 0
; Expected stdout: "Hello, world\n"

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

.data
msg BYTE "Hello, world", 13, 10
msg_len EQU $ - msg

.data?
written DWORD ?
hStdOut QWORD ?

.code
ex_07_hello_world PROC
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
        mov     eax, 0
    ret

ex_07_hello_world ENDP
main PROC
    call    ex_07_hello_world
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
