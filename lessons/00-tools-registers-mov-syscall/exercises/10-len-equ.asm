; Exercise 10: len equ (Win32 port)
;
; Declare a message and compute its length with EQU $ - label.
; Write the message using the computed length.
;
; Build: ml64 /c /Fo10-len-equ.obj 10-len-equ.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:10-len-equ.exe 10-len-equ.obj kernel32.lib
; Run: 10-len-equ.exe
;
; Expected output: Test message\n
; Expected exit code: 0

.DATA
; TODO: Declare 'msg' with "Test message" and CRLF
; TODO: Use 'msg_len EQU $ - msg' to compute length
.ERR <TODO: Declare msg and msg_len>

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
    
    ; Code provided; you must fix data declarations above
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
