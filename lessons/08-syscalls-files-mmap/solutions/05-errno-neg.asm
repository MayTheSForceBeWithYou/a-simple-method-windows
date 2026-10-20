; Exercise 05: errno neg
;
; On failed CreateFileA, call GetLastError, negate and clip to 127; exit with that code.
;
; Build: ml64 /c 05-errno-neg.asm && link /OUT:05-errno-neg.exe /ENTRY:main /SUBSYSTEM:CONSOLE 05-errno-neg.obj kernel32.lib
;
; Expected exit: (varies, typically 2 for ERROR_FILE_NOT_FOUND)

EXTERN CreateFileA:PROC
EXTERN GetLastError:PROC
EXTERN ExitProcess:PROC

.data
path BYTE "/nope", 0

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
    
    ; Get last error
    call GetLastError
    
    ; Negate and clip to 127 (simulate errno semantics)
    mov rcx, rax
    neg rcx
    and rcx, 127
    
    call ExitProcess
main ENDP
END
