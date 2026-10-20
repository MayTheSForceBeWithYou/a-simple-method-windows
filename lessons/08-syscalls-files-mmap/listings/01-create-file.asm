; Listing 01: Create and write to file
;
; Purpose: Demonstrate CreateFileA and WriteFile.
; Expected exit code: 0
; Expected output: Creates "test.txt" with "Hello, file!"
;
; Build: ml64 /c /Fo01-create-file.obj 01-create-file.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-create-file.exe 01-create-file.obj kernel32.lib

.CONST
filename DB "test.txt", 0
data DB "Hello, file!", 13, 10
data_len EQU $ - data

.DATA?
bytes_written DQ ?

.CODE

EXTRN CreateFileA:PROC
EXTRN WriteFile:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

; CreateFileA constants
GENERIC_WRITE       EQU 40000000h
CREATE_ALWAYS       EQU 2
FILE_ATTRIBUTE_NORMAL EQU 80h

main PROC FRAME
    push rbx
    .pushreg rbx
    sub rsp, 48                ; Shadow + alignment
    .allocstack 48
    .endprolog
    
    ; CreateFileA(filename, GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL)
    lea rcx, filename          ; lpFileName
    mov rdx, GENERIC_WRITE     ; dwDesiredAccess
    xor r8, r8                 ; dwShareMode = 0
    xor r9, r9                 ; lpSecurityAttributes = NULL
    mov DWORD PTR [rsp+32], CREATE_ALWAYS
    mov DWORD PTR [rsp+40], FILE_ATTRIBUTE_NORMAL
    mov QWORD PTR [rsp+48], 0  ; hTemplateFile = NULL
    call CreateFileA
    mov rbx, rax               ; Save file handle
    
    ; WriteFile(handle, data, len, &bytes_written, NULL)
    mov rcx, rbx
    lea rdx, data
    mov r8d, data_len
    lea r9, bytes_written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; CloseHandle
    mov rcx, rbx
    call CloseHandle
    
    xor ecx, ecx
    call ExitProcess
main ENDP

END
