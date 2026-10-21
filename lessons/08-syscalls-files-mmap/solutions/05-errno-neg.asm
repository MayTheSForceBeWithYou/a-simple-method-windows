; Exercise 05: errno neg
;
; On failed CreateFileA, exit with GetLastError (ERROR_FILE_NOT_FOUND=2).
;
; Build: ml64 /c 05-errno-neg.asm && link /OUT:05-errno-neg.exe /ENTRY:main /SUBSYSTEM:CONSOLE 05-errno-neg.obj kernel32.lib
;
; Expected exit: 2

EXTERN CreateFileA:PROC
EXTERN GetLastError:PROC
EXTERN ExitProcess:PROC

.data
path BYTE "C:\this_file_should_not_exist_asm_course_xyzzy.txt", 0

.code
main PROC
    sub rsp, 72
    
    ; CreateFileA - try to open nonexistent file
    lea rcx, path               ; lpFileName
    mov rdx, 80000000h          ; dwDesiredAccess = GENERIC_READ
    mov r8d, 0                  ; dwShareMode = 0
    mov r9, 0                   ; lpSecurityAttributes = NULL
    mov QWORD PTR [rsp+32], 3   ; dwCreationDisposition = OPEN_EXISTING
    mov QWORD PTR [rsp+40], 80h ; dwFlagsAndAttributes = FILE_ATTRIBUTE_NORMAL
    mov QWORD PTR [rsp+48], 0   ; hTemplateFile = NULL
    call CreateFileA
    
    ; GetLastError is the Windows-native error; Linux used -errno.
    call GetLastError
    mov rcx, rax
    
    call ExitProcess
main ENDP
END
