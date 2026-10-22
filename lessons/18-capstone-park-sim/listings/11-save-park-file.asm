; Listing 11: Save park file with Win32 I/O (LESSON.md block 11)
; Expected exit: 0
; Expected stdout: (none)

.DATA
path DB "park.sav", 0
header DB "PK01", 1, 0, 0, 0
HLEN EQU $ - header

.DATA?
map DB 64 DUP(?)
bytesWritten DWORD ?
hFile QWORD ?

.CODE
EXTRN CreateFileA:PROC
EXTRN WriteFile:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    sub     rsp, 64
    .allocstack 64
    .endprolog

    lea     rcx, path
    mov     edx, 40000000h
    xor     r8d, r8d
    xor     r9d, r9d
    mov     DWORD PTR [rsp+32], 2
    mov     DWORD PTR [rsp+40], 80h
    mov     QWORD PTR [rsp+48], 0
    call    CreateFileA
    cmp     rax, -1
    je      fail
    mov     rbx, rax

    mov     rcx, rbx
    lea     rdx, header
    mov     r8d, HLEN
    lea     r9, bytesWritten
    mov     QWORD PTR [rsp+32], 0
    call    WriteFile

    mov     rcx, rbx
    lea     rdx, map
    mov     r8d, 64
    lea     r9, bytesWritten
    mov     QWORD PTR [rsp+32], 0
    call    WriteFile

    mov     rcx, rbx
    call    CloseHandle

    xor     ecx, ecx
    call    ExitProcess

fail:
    mov     ecx, 1
    call    ExitProcess
main ENDP
END
