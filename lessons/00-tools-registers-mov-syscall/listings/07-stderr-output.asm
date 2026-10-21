; Listing 07: Writing to stderr instead of stdout
;
; Purpose: Demonstrates using GetStdHandle with STD_ERROR_HANDLE.
; Expected exit: 0
; Expected stdout: "Error message\n"
;
; Build: ml64 /c /Fo07-stderr-output.obj 07-stderr-output.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:07-stderr-output.exe 07-stderr-output.obj kernel32.lib
; Run: 07-stderr-output.exe 2>&1

.DATA
msg DB "Error message", 13, 10
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
    sub rsp, 48
    .allocstack 48
    .endprolog

    ; GetStdHandle(STD_ERROR_HANDLE = -12)
    mov ecx, -12               ; STD_ERROR_HANDLE (not -11 for stdout)
    call GetStdHandle
    mov rbx, rax

    ; WriteFile to stderr
    mov rcx, rbx
    lea rdx, msg
    mov r8d, msg_len
    lea r9, bytes_written
    mov qword ptr [rsp+32], 0
    call WriteFile

    xor ecx, ecx
    add rsp, 48
    pop rbx
    call ExitProcess
main ENDP

END
