; Exercise 07: hello world (Win32 port) - SOLUTION
;
; Write "Hello, world\n" to stdout, then exit 0.
;
; Build: ml64 /c /Fo07-hello-world.obj 07-hello-world.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:07-hello-world.exe 07-hello-world.obj kernel32.lib
; Run: 07-hello-world.exe
;
; Expected output: Hello, world\n
; Expected exit code: 0

.DATA
msg DB "Hello, world", 13, 10
msg_len EQU $ - msg

.DATA?
bytes_written DQ ?

.CODE

EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push rbx
    .pushreg rbx
    sub rsp, 32
    .allocstack 32
    .endprolog
    
    ; Get stdout handle
    mov ecx, -11               ; STD_OUTPUT_HANDLE
    call GetStdHandle
    mov rbx, rax               ; Save handle in nonvolatile RBX
    
    ; WriteFile(handle, buffer, count, &bytes_written, NULL)
    mov rcx, rbx
    lea rdx, msg
    mov r8d, msg_len
    lea r9, bytes_written
    mov qword ptr [rsp+32], 0
    call WriteFile
    
    ; Exit
    xor ecx, ecx
    call ExitProcess
main ENDP

END
