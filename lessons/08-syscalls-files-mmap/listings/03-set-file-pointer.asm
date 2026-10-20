; 03-set-file-pointer.asm
;
; Purpose: Demonstrate seeking in a file using SetFilePointer
; Expected exit code: 0
; Expected stdout: (none)
;
; Demonstrates:
; - SetFilePointer to move file position (equivalent to lseek)
; - FILE_BEGIN (0), FILE_CURRENT (1), FILE_END (2) constants

.DATA
filename DB "test.txt", 0

.CODE

EXTRN CreateFileA:PROC
EXTRN SetFilePointer:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
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
    
    mov     rbx, rax
    
    ; SetFilePointer(hFile, 0, NULL, FILE_BEGIN)
    ; Seeks to beginning of file
    mov     rcx, rbx
    xor     edx, edx            ; lDistanceToMove = 0
    xor     r8, r8              ; lpDistanceToMoveHigh = NULL
    xor     r9d, r9d            ; dwMoveMethod = FILE_BEGIN (0)
    call    SetFilePointer
    
    ; SetFilePointer(hFile, 5, NULL, FILE_CURRENT)
    ; Moves 5 bytes forward from current position
    mov     rcx, rbx
    mov     edx, 5
    xor     r8, r8
    mov     r9d, 1              ; FILE_CURRENT
    call    SetFilePointer
    
    ; CloseHandle
    mov     rcx, rbx
    call    CloseHandle
    
    xor     ecx, ecx
    jmp     done
    
error:
    mov     ecx, 1
    
done:
    add     rsp, 40
    call    ExitProcess
main ENDP

END
