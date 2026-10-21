; Listing 17: WriteFile with RIP-relative msg (LESSON.md block 17)
;
; Expected exit: 0
; Expected stdout: "hi\n"

.CODE
EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC

.DATA
msg BYTE "hi", 10
msg_len EQU $ - msg

.DATA?
written DWORD ?

main PROC FRAME
    push rbx
    .pushreg rbx
    sub rsp, 40
    .allocstack 40
    .endprolog

    mov ecx, -11
    call GetStdHandle
    mov rbx, rax

    mov rcx, rbx
    lea rdx, msg
    mov r8, msg_len
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile

    add     rsp, 40
    pop     rbx
    xor     ecx, ecx
    call    ExitProcess
main ENDP

END
