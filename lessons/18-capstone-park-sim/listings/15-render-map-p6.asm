; Listing 15: Write 2x2 map as P6 PPM (LESSON.md)
; Expected exit: 23
; Expected stdout: (none)
; Expected side effect: creates map.ppm (11-byte P6 header + 12 RGB bytes = 23 written)

.DATA
path DB "map.ppm", 0
hdr DB "P6", 10, "2 2", 10, "255", 10
HLEN EQU $ - hdr
map_cells BYTE 255, 0, 0, 0, 0, 255, 0, 0, 0, 0, 255, 0
PIXEL_BYTES EQU 12
TOTAL_BYTES EQU HLEN + PIXEL_BYTES

.DATA?
bytesWritten DWORD ?
hFile QWORD ?
totalWritten DWORD ?

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

    mov     totalWritten, 0

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
    test    rax, rax
    jz      fail_close
    add     totalWritten, bytesWritten

    mov     rcx, rbx
    lea     rdx, map_cells
    mov     r8d, PIXEL_BYTES
    lea     r9, bytesWritten
    mov     QWORD PTR [rsp+32], 0
    call    WriteFile
    test    rax, rax
    jz      fail_close
    add     totalWritten, bytesWritten

    mov     rcx, rbx
    call    CloseHandle

    mov     ecx, DWORD PTR totalWritten
    call    ExitProcess

fail_close:
    mov     rcx, rbx
    call    CloseHandle

fail:
    mov     ecx, 1
    call    ExitProcess
main ENDP
END
