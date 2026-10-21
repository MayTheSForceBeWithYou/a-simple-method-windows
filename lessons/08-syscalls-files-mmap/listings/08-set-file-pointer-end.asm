; Listing 08: SetFilePointerEx seek to end (LESSON.md asm block 8)
;
; Purpose: Position at end of file with FILE_END and offset 0 (append setup).
; Expected exit: 0
; Expected stdout: (none)
;
; Build: ml64 /c /Fo08-set-file-pointer-end.obj 08-set-file-pointer-end.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:08-set-file-pointer-end.exe 08-set-file-pointer-end.obj kernel32.lib

.DATA
filename DB "test.txt", 0

.CODE

EXTRN CreateFileA:PROC
EXTRN SetFilePointerEx:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push rbx
    .pushreg rbx
    sub rsp, 48
    .allocstack 48
    .endprolog

    lea rcx, filename
    mov edx, 40000000h
    xor r8d, r8d
    xor r9d, r9d
    mov DWORD PTR [rsp+32], 4
    mov DWORD PTR [rsp+40], 80h
    mov QWORD PTR [rsp+48], 0
    call CreateFileA
    cmp rax, -1
    jne have_handle
    mov ecx, 1
    call ExitProcess

have_handle:
    mov rbx, rax

    mov rcx, rbx
    xor rdx, rdx
    xor r8, r8
    mov r9d, 2                  ; FILE_END
    call SetFilePointerEx
    test rax, rax
    jz seek_failed

    mov rcx, rbx
    call CloseHandle
    xor ecx, ecx
    call ExitProcess

seek_failed:
    mov ecx, 2
    call ExitProcess
main ENDP

END
