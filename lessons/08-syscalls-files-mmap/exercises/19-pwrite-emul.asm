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
    .ERR <TODO: Open NUL for writing>
    
    ; TODO: SetFilePointer(handle, 0, NULL, FILE_BEGIN)
    .ERR <TODO: Seek to offset 0>
    
    ; TODO: WriteFile(handle, message, message_len, &bytesWritten, NULL)
    .ERR <TODO: Write message>
    
    ; TODO: CloseHandle, exit 0
    .ERR <TODO: Close and exit>
    
    xor     ecx, ecx
    add     rsp, 48
    pop     rbx
    call    ExitProcess
main ENDP

END
