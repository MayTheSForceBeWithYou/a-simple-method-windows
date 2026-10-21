; Exercise 09: write stderr (Win32 port)
;
; Write "Error\n" to stderr (not stdout).
;
; Build: ml64 /c /Fo09-write-stderr.obj 09-write-stderr.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:09-write-stderr.exe 09-write-stderr.obj kernel32.lib
; Run: 09-write-stderr.exe 2>&1
;
; Expected output: (to stderr) Error\n
; Expected exit: 0
; Expected stdout: (none)
.DATA
msg DB "Error", 13, 10
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
    
    ; TODO: Get stderr handle (STD_ERROR_HANDLE = -12, not -11)
    ; TODO: Write message to stderr
    

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
