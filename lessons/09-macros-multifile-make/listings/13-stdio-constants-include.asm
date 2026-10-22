; Listing 13: INCLUDE constants.inc for STD_OUTPUT_HANDLE (LESSON.md block 13)
;
; Purpose: Shared constants in an include file; write "ok" to stdout.
; Expected exit: 0
; Expected stdout: "ok\n"
;
; Build from listings dir:
; ml64 /c /Fo13-stdio-constants-include.obj 13-stdio-constants-include.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:13-stdio-constants-include.exe 13-stdio-constants-include.obj kernel32.lib

INCLUDE constants.inc

.DATA
line BYTE "ok", 13, 10
line_len EQU $ - line

.DATA?
written DWORD ?

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

    mov ecx, STD_OUTPUT_HANDLE
    call GetStdHandle
    mov rbx, rax

    mov rcx, rbx
    lea rdx, line
    mov r8d, line_len
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile

    xor ecx, ecx
    call ExitProcess
main ENDP

END
