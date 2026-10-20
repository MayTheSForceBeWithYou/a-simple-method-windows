; Exercise 09: write stderr (Win32 port) - SOLUTION
;
; Write "Error\n" to stderr (not stdout).
;
; Build: ml64 /c /Fo09-write-stderr.obj 09-write-stderr.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:09-write-stderr.exe 09-write-stderr.obj kernel32.lib
; Run: 09-write-stderr.exe 2>&1
;
; Expected output: (to stderr) Error\n
; Expected exit code: 0

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
    
    ; Get stderr handle
    mov ecx, -12               ; STD_ERROR_HANDLE (not -11)
    call GetStdHandle
    mov rbx, rax
    
    ; Write to stderr
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
