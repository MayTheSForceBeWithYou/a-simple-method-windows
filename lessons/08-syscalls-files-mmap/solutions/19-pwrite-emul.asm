; Exercise 19: pwrite emul
;
; Emulate pwrite via SetFilePointerEx+WriteFile on NUL: open, seek end, write. Exit 0 on success.
;
; Build: ml64 /c 19-pwrite-emul.asm && link /OUT:19-pwrite-emul.exe /ENTRY:main /SUBSYSTEM:CONSOLE 19-pwrite-emul.obj kernel32.lib
;
; Expected exit: 0

EXTERN CreateFileA:PROC
EXTERN SetFilePointerEx:PROC
EXTERN WriteFile:PROC
EXTERN CloseHandle:PROC
EXTERN ExitProcess:PROC

.data
path BYTE "NUL", 0
msg BYTE "x"

.data?
written DWORD ?
newPos QWORD ?

.code
main PROC
    sub rsp, 72
    
    ; CreateFileA for NUL device
    lea rcx, path               ; lpFileName
    mov rdx, 40000000h          ; dwDesiredAccess = GENERIC_WRITE
    mov r8d, 0                  ; dwShareMode = 0
    mov r9, 0                   ; lpSecurityAttributes = NULL
    mov QWORD PTR [rsp+32], 3   ; dwCreationDisposition = OPEN_EXISTING
    mov QWORD PTR [rsp+40], 80h ; dwFlagsAndAttributes = FILE_ATTRIBUTE_NORMAL
    mov QWORD PTR [rsp+48], 0   ; hTemplateFile = NULL
    call CreateFileA
    
    ; Check for failure
    cmp rax, -1
    je L_e
    
    ; Save handle
    mov rbx, rax
    
    ; SetFilePointerEx(handle, 0, &newPos, FILE_END)
    mov rcx, rbx
    mov rdx, 0                  ; liDistanceToMove = 0
    lea r8, newPos              ; lpNewFilePointer
    mov r9d, 2                  ; dwMoveMethod = FILE_END
    call SetFilePointerEx
    
    ; Write 1 byte
    mov rcx, rbx
    lea rdx, msg
    mov r8d, 1
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Close handle
    mov rcx, rbx
    call CloseHandle
    
    ; Exit 0
    mov rcx, 0
    jmp L_o
    
L_e:
    ; Exit 1 on error
    mov rcx, 1
    
L_o:
    call ExitProcess
main ENDP
END
