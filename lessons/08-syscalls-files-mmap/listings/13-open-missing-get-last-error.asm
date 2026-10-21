; Listing 13: Open missing file; exit with GetLastError code (LESSON.md)
;
; Purpose: CreateFileA failure returns INVALID_HANDLE_VALUE; error via GetLastError.
; Expected exit: 2 (ERROR_FILE_NOT_FOUND)
; Expected stdout: (none)
;
; Build: ml64 /c /Fo13-open-missing-get-last-error.obj 13-open-missing-get-last-error.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:13-open-missing-get-last-error.exe 13-open-missing-get-last-error.obj kernel32.lib

.DATA
path DB "C:\no\such\file.txt", 0

.CODE

EXTRN CreateFileA:PROC
EXTRN CloseHandle:PROC
EXTRN GetLastError:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push rbx
    .pushreg rbx
    sub rsp, 56
    .allocstack 56
    .endprolog

    lea rcx, path
    mov edx, 80000000h
    xor r8d, r8d
    xor r9d, r9d
    mov QWORD PTR [rsp+32], 3
    mov QWORD PTR [rsp+40], 80h
    mov QWORD PTR [rsp+48], 0
    call CreateFileA

    cmp rax, -1
    je failed

    mov rbx, rax
    mov rcx, rbx
    call CloseHandle
    xor ecx, ecx
    call ExitProcess

failed:
    call GetLastError
    mov ecx, eax
    call ExitProcess
main ENDP

END
