; Listing 15: CreatePipe read/write handles (LESSON.md)
; Expected exit: 0
; Expected stdout: (none)

.DATA?
hRead QWORD ?
hWrite QWORD ?

.CODE
EXTRN CreatePipe:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog

    lea     rcx, hRead
    lea     rdx, hWrite
    xor     r8, r8
    xor     r9d, r9d
    call    CreatePipe
    test    rax, rax
    jz      fail

    mov     rcx, hRead
    call    CloseHandle
    mov     rcx, hWrite
    call    CloseHandle

    xor     ecx, ecx
    call    ExitProcess

fail:
    mov     ecx, 1
    call    ExitProcess
main ENDP
END
