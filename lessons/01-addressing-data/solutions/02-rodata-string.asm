; Exercise 02: rodata string (Win32 port) - SOLUTION
;
; Put "rodata\r\n" in .CONST (read-only), write it, exit 0.
;
; Build: ml64 /c /Fo02-rodata-string.obj 02-rodata-string.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-rodata-string.exe 02-rodata-string.obj kernel32.lib
; Run: 02-rodata-string.exe
;
; Expected output: rodata\n
; Expected exit code: 0

.CONST
msg DB "rodata", 13, 10
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
    
    mov ecx, -11
    call GetStdHandle
    mov rbx, rax
    
    mov rcx, rbx
    lea rdx, msg
    mov r8d, msg_len
    lea r9, bytes_written
    mov qword ptr [rsp+32], 0
    call WriteFile
    
    xor ecx, ecx
    call ExitProcess
main ENDP

END
