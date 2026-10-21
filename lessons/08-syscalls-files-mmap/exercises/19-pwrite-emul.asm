; 19-pwrite-emul.asm
;
; Open NUL, seek to position 0, write data, close, exit 0.
;
; Task: CreateFileA("NUL", GENERIC_WRITE, ..., OPEN_EXISTING),
;       SetFilePointer(handle, 0, NULL, FILE_BEGIN),
;       WriteFile("Test"), CloseHandle, exit 0.
;
; Hint: Emulates pwrite by seeking then writing.

.DATA
filename DB "NUL", 0
message DB "Test"
message_len EQU $ - message
bytesWritten DWORD ?

.CODE

EXTRN CreateFileA:PROC
EXTRN SetFilePointer:PROC
EXTRN WriteFile:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    sub     rsp, 48
    .allocstack 48
    .endprolog
    
    ; TODO: CreateFileA("NUL", GENERIC_WRITE, ...)
    
    ; TODO: SetFilePointer(handle, 0, NULL, FILE_BEGIN)
    
    ; TODO: WriteFile(handle, message, message_len, &bytesWritten, NULL)
    
    ; TODO: CloseHandle, exit 0
    
    xor     ecx, ecx
    add     rsp, 48
    pop     rbx
    call    ExitProcess

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
