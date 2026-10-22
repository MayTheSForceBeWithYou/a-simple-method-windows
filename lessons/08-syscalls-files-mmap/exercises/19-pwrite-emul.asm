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
EXTRN ex_19_pwrite_emul:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_19_pwrite_emul in this file.
    call    ex_19_pwrite_emul
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
