; 01-create-file-write.asm
;
; Purpose: Create/truncate a file and write to it using Win32 APIs
; Expected exit code: 0
; Expected stdout: (none)
; Expected side effect: Creates/truncates test.txt with "Hello, file!\n"
;
; Demonstrates:
; - CreateFileA with CREATE_ALWAYS (equivalent to O_CREAT | O_TRUNC)
; - WriteFile to write data
; - CloseHandle to release the file handle
; - Error checking with INVALID_HANDLE_VALUE

.DATA
filename DB "test.txt", 0
message DB "Hello, file!", 13, 10
message_len EQU $ - message

bytesWritten DWORD ?

.CODE

EXTRN CreateFileA:PROC
EXTRN WriteFile:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 56
    .allocstack 56
    .endprolog
    
    ; CreateFileA(filename, GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL)
    lea     rcx, filename       ; lpFileName
    mov     edx, 40000000h      ; dwDesiredAccess = GENERIC_WRITE
    xor     r8d, r8d            ; dwShareMode = 0
    xor     r9d, r9d            ; lpSecurityAttributes = NULL
    mov     DWORD PTR [rsp+32], 2 ; dwCreationDisposition = CREATE_ALWAYS
    mov     DWORD PTR [rsp+40], 80h ; dwFlagsAndAttributes = FILE_ATTRIBUTE_NORMAL
    mov     QWORD PTR [rsp+48], 0 ; hTemplateFile = NULL
    call    CreateFileA
    
    ; Check if handle is valid (not INVALID_HANDLE_VALUE = -1)
    cmp     rax, -1
    je      error
    
    mov     rbx, rax            ; Save file handle
    
    ; WriteFile(hFile, message, message_len, &bytesWritten, NULL)
    mov     rcx, rbx            ; hFile
    lea     rdx, message        ; lpBuffer
    mov     r8d, message_len    ; nNumberOfBytesToWrite
    lea     r9, bytesWritten    ; lpNumberOfBytesWritten
    mov     QWORD PTR [rsp+32], 0 ; lpOverlapped = NULL
    call    WriteFile
    
    ; CloseHandle(hFile)
    mov     rcx, rbx
    call    CloseHandle
    
    xor     ecx, ecx
    jmp     done
    
error:
    mov     ecx, 1
    
done:
    call    ExitProcess
main ENDP

END
