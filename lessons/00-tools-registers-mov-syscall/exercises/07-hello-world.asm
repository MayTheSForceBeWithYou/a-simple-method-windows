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
EXTRN ex_07_hello_world:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_07_hello_world (student routine; defined in solutions/).
    call    ex_07_hello_world
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
