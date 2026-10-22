; Exercise: 07-hello-world
;
; Write "Hello, world\n" to stdout, then exit 0.
; Expected stdout: "Hello, world\n"
;
; Contract: implement `ex_07_hello_world` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
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
    ; TODO: write ex_07_hello_world in this file.
    call    ex_07_hello_world
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
