; Listing 09: CloseHandle success check (LESSON.md asm block 9)
;
; Purpose: Close an open file handle and test the BOOL return.
; Expected exit: 0
; Expected stdout: (none)
;
; Build: ml64 /c /Fo09-close-handle.obj 09-close-handle.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:09-close-handle.exe 09-close-handle.obj kernel32.lib

.DATA
filename DB "test.txt", 0

.CODE

EXTRN CreateFileA:PROC
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
    call CloseHandle
    test rax, rax
    jz close_failed

    xor ecx, ecx
    call ExitProcess

close_failed:
    mov ecx, 3
    call ExitProcess
main ENDP

END
