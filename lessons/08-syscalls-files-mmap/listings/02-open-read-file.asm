; 02-open-read-file.asm
;
; Purpose: Open an existing file and read from it
; Expected exit code: 1
; Expected stdout: (none)
;
; Demonstrates:
; - CreateFileA with OPEN_EXISTING (equivalent to open with O_RDONLY)
; - ReadFile to read data
; - Error handling with INVALID_HANDLE_VALUE

.DATA
filename DB "test.txt", 0
buffer DB 256 DUP(?)
bytesRead DWORD ?

.CODE

EXTRN CreateFileA:PROC
EXTRN ReadFile:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 56
    .allocstack 56
    .endprolog
    
    ; CreateFileA(filename, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL)
    lea     rcx, filename       ; lpFileName
    mov     edx, 80000000h      ; dwDesiredAccess = GENERIC_READ
    mov     r8d, 1              ; dwShareMode = FILE_SHARE_READ
    xor     r9d, r9d            ; lpSecurityAttributes = NULL
    mov     DWORD PTR [rsp+32], 3 ; dwCreationDisposition = OPEN_EXISTING
    mov     DWORD PTR [rsp+40], 80h ; dwFlagsAndAttributes = FILE_ATTRIBUTE_NORMAL
    mov     QWORD PTR [rsp+48], 0 ; hTemplateFile = NULL
    call    CreateFileA
    
    cmp     rax, -1
    je      error
    
    mov     rbx, rax            ; Save file handle
    
    ; ReadFile(hFile, buffer, 256, &bytesRead, NULL)
    mov     rcx, rbx
    lea     rdx, buffer
    mov     r8d, 256
    lea     r9, bytesRead
    mov     QWORD PTR [rsp+32], 0
    call    ReadFile
    
    ; CloseHandle
    mov     rcx, rbx
    call    CloseHandle
    
    ; Exit with first byte (or 0 if empty)
    movzx   ecx, BYTE PTR buffer
    jmp     done
    
error:
    mov     ecx, 1
    
done:
    call    ExitProcess
main ENDP

END
