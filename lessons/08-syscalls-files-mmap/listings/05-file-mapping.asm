; 05-file-mapping.asm
;
; Purpose: Map a file into memory (file-backed mmap equivalent)
; Expected exit code: First byte of mapped file
; Expected stdout: (none)
;
; Demonstrates:
; - CreateFileMappingA to create a file mapping object
; - MapViewOfFile to map the file into process address space
; - UnmapViewOfFile and CloseHandle to clean up

.DATA
filename DB "test.txt", 0

.CODE

EXTRN CreateFileA:PROC
EXTRN CreateFileMappingA:PROC
EXTRN MapViewOfFile:PROC
EXTRN UnmapViewOfFile:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push    r12
    .pushreg r12
    push    r13
    .pushreg r13
    sub     rsp, 40
    .allocstack 40
    .endprolog
    
    ; Open file for reading
    lea     rcx, filename
    mov     edx, 80000000h      ; GENERIC_READ
    mov     r8d, 1              ; FILE_SHARE_READ
    xor     r9d, r9d
    mov     DWORD PTR [rsp+32], 3 ; OPEN_EXISTING
    mov     DWORD PTR [rsp+40], 80h
    mov     QWORD PTR [rsp+48], 0
    call    CreateFileA
    
    cmp     rax, -1
    je      error
    
    mov     rbx, rax            ; File handle
    
    ; CreateFileMappingA(hFile, NULL, PAGE_READONLY, 0, 0, NULL)
    mov     rcx, rbx
    xor     rdx, rdx            ; lpFileMappingAttributes = NULL
    mov     r8d, 2              ; flProtect = PAGE_READONLY
    xor     r9d, r9d            ; dwMaximumSizeHigh = 0
    mov     QWORD PTR [rsp+32], 0 ; dwMaximumSizeLow = 0 (use file size)
    mov     QWORD PTR [rsp+40], 0 ; lpName = NULL
    call    CreateFileMappingA
    
    test    rax, rax
    jz      error_close_file
    
    mov     r12, rax            ; Mapping handle
    
    ; MapViewOfFile(hFileMappingObject, FILE_MAP_READ, 0, 0, 0)
    mov     rcx, r12
    mov     edx, 4              ; dwDesiredAccess = FILE_MAP_READ
    xor     r8d, r8d            ; dwFileOffsetHigh = 0
    xor     r9d, r9d            ; dwFileOffsetLow = 0
    mov     QWORD PTR [rsp+32], 0 ; dwNumberOfBytesToMap = 0 (entire file)
    call    MapViewOfFile
    
    test    rax, rax
    jz      error_close_mapping
    
    mov     r13, rax            ; View address
    
    ; Read first byte from mapped view
    movzx   r14d, BYTE PTR [r13]
    
    ; Unmap view
    mov     rcx, r13
    call    UnmapViewOfFile
    
    ; Close mapping handle
    mov     rcx, r12
    call    CloseHandle
    
    ; Close file handle
    mov     rcx, rbx
    call    CloseHandle
    
    ; Exit with first byte
    mov     ecx, r14d
    jmp     done
    
error_close_mapping:
    mov     rcx, r12
    call    CloseHandle
    
error_close_file:
    mov     rcx, rbx
    call    CloseHandle
    
error:
    mov     ecx, 1
    
done:
    call    ExitProcess
main ENDP

END
