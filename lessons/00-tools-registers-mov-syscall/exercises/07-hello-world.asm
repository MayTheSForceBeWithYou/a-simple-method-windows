; Exercise 07: hello world (Win32 port)
;
; Write "Hello, world\n" to stdout, then exit 0.
;
; Build: ml64 /c /Fo07-hello-world.obj 07-hello-world.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:07-hello-world.exe 07-hello-world.obj kernel32.lib
; Run: 07-hello-world.exe
;
; Expected output: Hello, world\n
; Expected exit: 0
; Expected stdout: (none)
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
    
    ; TODO: Get stdout handle with GetStdHandle(-11)
    ; TODO: Call WriteFile with proper arguments
    ; TODO: Exit with status 0
    

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
