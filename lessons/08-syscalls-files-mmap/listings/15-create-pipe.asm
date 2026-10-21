; Listing 15: CreatePipe, WriteFile, ReadFile round trip
; Expected exit: 3
; Expected stdout: (none)

.DATA
payload BYTE "ABC"

.DATA?
hRead QWORD ?
hWrite QWORD ?
readBuf BYTE 8 DUP(?)
bytesWritten DWORD ?
bytesRead DWORD ?

.CODE
EXTRN CreatePipe:PROC
EXTRN WriteFile:PROC
EXTRN ReadFile:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    sub     rsp, 64
    .allocstack 64
    .endprolog

    lea     rcx, hRead
    lea     rdx, hWrite
    xor     r8, r8
    xor     r9d, r9d
    call    CreatePipe
    test    rax, rax
    jz      fail

    mov     rcx, hWrite
    lea     rdx, payload
    mov     r8d, 3
    lea     r9, bytesWritten
    mov     QWORD PTR [rsp+32], 0
    call    WriteFile
    test    rax, rax
    jz      fail_close

    mov     rcx, hRead
    lea     rdx, readBuf
    mov     r8d, 3
    lea     r9, bytesRead
    mov     QWORD PTR [rsp+32], 0
    call    ReadFile
    test    rax, rax
    jz      fail_close

    mov     ecx, DWORD PTR bytesRead
    jmp     cleanup

fail_close:
    mov     rcx, hRead
    call    CloseHandle
    mov     rcx, hWrite
    call    CloseHandle
    mov     ecx, 1
    jmp     exit_proc

cleanup:
    mov     rcx, hRead
    call    CloseHandle
    mov     rcx, hWrite
    call    CloseHandle
    jmp     exit_proc

fail:
    mov     ecx, 1

exit_proc:
    call    ExitProcess
main ENDP
END
