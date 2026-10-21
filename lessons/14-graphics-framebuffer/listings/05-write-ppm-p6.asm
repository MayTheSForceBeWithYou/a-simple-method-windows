; Listing 05: Write P6 PPM via Win32 (LESSON.md block 5)
; Expected exit: 0
; Expected stdout: (none)

.DATA
path DB "out.ppm", 0
hdr DB "P6", 10, "4 2", 10, "255", 10
HLEN EQU $ - hdr

.DATA?
px DB 24 DUP(?)
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

    xor     rcx, rcx
paint:
    cmp     rcx, 24
    jge     write_file
    mov     BYTE PTR px[rcx], 255
    add     rcx, 3
    jmp     paint

write_file:
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
    lea     rdx, hdr
    mov     r8d, HLEN
    lea     r9, bytesWritten
    mov     QWORD PTR [rsp+32], 0
    call    WriteFile

    mov     rcx, rbx
    lea     rdx, px
    mov     r8d, 24
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
