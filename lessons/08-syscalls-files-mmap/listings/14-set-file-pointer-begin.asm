; Listing 14: SetFilePointerEx seek to beginning (LESSON.md asm block 7)
;
; Purpose: FILE_BEGIN seek with lpNewFilePointer receiving offset 0.
; Expected exit: 0
; Expected stdout: (none)
;
; Build: ml64 /c /Fo14-set-file-pointer-begin.obj 14-set-file-pointer-begin.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:14-set-file-pointer-begin.exe 14-set-file-pointer-begin.obj kernel32.lib

.DATA
filename DB "test.txt", 0

.DATA?
newPos QWORD ?

.CODE

EXTRN CreateFileA:PROC
EXTRN SetFilePointerEx:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push rbx
    .pushreg rbx
    sub rsp, 64
    .allocstack 64
    .endprolog

    lea rcx, filename
    mov edx, 80000000h
    xor r8d, r8d
    xor r9d, r9d
    mov DWORD PTR [rsp+32], 3
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
    lea r8, newPos
    xor r9d, r9d              ; FILE_BEGIN
    call SetFilePointerEx
    test rax, rax
    jz seek_failed

    cmp newPos, 0
    jne bad_pos

    mov rcx, rbx
    call CloseHandle
    xor ecx, ecx
    call ExitProcess

bad_pos:
    mov ecx, 4
    call ExitProcess

seek_failed:
    mov ecx, 2
    call ExitProcess
main ENDP

END
