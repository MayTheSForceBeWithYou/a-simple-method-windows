; Listing 07: Writing to stderr instead of stdout
;
; Purpose: Demonstrates using GetStdHandle with STD_ERROR_HANDLE.
; Expected exit: 0
; Expected output: (to stderr) Error message
;
; Build: ml64 /c /Fo07-stderr-output.obj 07-stderr-output.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:07-stderr-output.exe 07-stderr-output.obj kernel32.lib
; Run: 07-stderr-output.exe 2>&1

.DATA
msg DB "Error message", 13, 10
msg_len EQU $ - msg

.DATA?
bytes_written DWORD ?

.CODE

EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC

main PROC
    sub     rsp, 56

    mov     rcx, -12
    call    GetStdHandle

    mov     rcx, rax
    lea     rdx, msg
    mov     r8d, msg_len
    lea     r9, bytes_written
    mov     QWORD PTR [rsp+32], 0
    call    WriteFile

    xor     ecx, ecx
    call    ExitProcess
main ENDP

END
