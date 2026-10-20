; Exercise 08: two writes (Win32 port) - SOLUTION
;
; Write two separate strings to stdout.
;
; Build: ml64 /c /Fo08-two-writes.obj 08-two-writes.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:08-two-writes.exe 08-two-writes.obj kernel32.lib
; Run: 08-two-writes.exe
;
; Expected output: Line one\nLine two\n
; Expected exit code: 0

.DATA
msg1 DB "Line one", 13, 10
msg1_len EQU $ - msg1
msg2 DB "Line two", 13, 10
msg2_len EQU $ - msg2

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
    mov ecx, -11
    call GetStdHandle
    mov rbx, rax
    
    ; Write first message
    mov rcx, rbx
    lea rdx, msg1
    mov r8d, msg1_len
    lea r9, bytes_written
    mov qword ptr [rsp+32], 0
    call WriteFile
    
    ; Write second message
    mov rcx, rbx
    lea rdx, msg2
    mov r8d, msg2_len
    lea r9, bytes_written
    mov qword ptr [rsp+32], 0
    call WriteFile
    
    ; Exit
    xor ecx, ecx
    call ExitProcess
main ENDP

END
