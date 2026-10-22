; Exercise: 05-get-last-error-open
;
; On failed CreateFileA, exit with GetLastError (ERROR_FILE_NOT_FOUND=2).
; Expected exit: 2
;
.data
path BYTE "C:\this_file_should_not_exist_asm_course_xyzzy.txt", 0

.code
ex_05_get_last_error_open PROC
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
    
    mov     eax, eax
    add     rsp, 72
    ret
ex_05_get_last_error_open ENDP
main PROC
    sub     rsp, 40
    call    ex_05_get_last_error_open
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
