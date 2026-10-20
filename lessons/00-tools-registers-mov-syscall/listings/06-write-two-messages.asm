; Listing 06: Multiple writes to stdout
;
; Purpose: Demonstrates calling WriteFile multiple times with different messages.
; Expected exit code: 0
; Expected output: First line\nSecond line\n
;
; Build: ml64 /c /Fo06-write-two-messages.obj 06-write-two-messages.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:06-write-two-messages.exe 06-write-two-messages.obj kernel32.lib

.DATA
msg1 DB "First line", 13, 10
msg1_len EQU $ - msg1
msg2 DB "Second line", 13, 10
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
    push rsi
    .pushreg rsi
    sub rsp, 40                ; Shadow space + alignment (total 56, 16-aligned)
    .allocstack 40
    .endprolog

    ; Get stdout handle
    mov ecx, -11
    call GetStdHandle
    mov rbx, rax               ; Save handle

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
