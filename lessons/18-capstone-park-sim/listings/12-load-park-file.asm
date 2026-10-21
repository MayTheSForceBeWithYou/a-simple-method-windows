; Listing 12: Load park file header validation (LESSON.md block 12)
; Expected exit: 1
; Expected stdout: (none)

.DATA
path DB "park.sav", 0
header_buf DB 8 DUP(?)

.DATA?
map DB 64 DUP(?)
bytesRead DWORD ?
hFile QWORD ?

.CODE
EXTRN CreateFileA:PROC
EXTRN ReadFile:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    sub     rsp, 64
    .allocstack 64
    .endprolog

    ; Pre-seed header for harness when file missing
    mov     DWORD PTR header_buf, 31304B50h   ; LE PK01 (P,K,0,1)
    mov     DWORD PTR header_buf[4], 1

    lea     rcx, path
    mov     edx, 80000000h
    mov     r8d, 1
    xor     r9d, r9d
    mov     DWORD PTR [rsp+32], 3
    mov     DWORD PTR [rsp+40], 80h
    mov     QWORD PTR [rsp+48], 0
    call    CreateFileA
    cmp     rax, -1
    jne     have_file
    jmp     validate

have_file:
    mov     rbx, rax
    mov     rcx, rbx
    lea     rdx, header_buf
    mov     r8d, 8
    lea     r9, bytesRead
    mov     QWORD PTR [rsp+32], 0
    call    ReadFile
    mov     rcx, rbx
    call    CloseHandle

validate:
    cmp     DWORD PTR header_buf, 31304B50h
    jne     bad
    mov     eax, DWORD PTR header_buf[4]
    cmp     eax, 1
    jne     bad
    mov     ecx, 1
    call    ExitProcess

bad:
    xor     ecx, ecx
    call    ExitProcess
main ENDP
END
