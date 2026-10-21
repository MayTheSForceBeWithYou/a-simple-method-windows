; Listing 17: LESSON.md asm block 17
; Expected exit: 0
; Expected stdout: "(none)\n"

.DATA
msg DB "X", 13, 10
msg_len EQU $ - msg
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
    mov ecx, -11
    call GetStdHandle
    mov rbx, rax
    mov rcx, rbx
    lea rdx, msg
    mov r8d, msg_len
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    xor ecx, ecx
    call ExitProcess
main ENDP
END
