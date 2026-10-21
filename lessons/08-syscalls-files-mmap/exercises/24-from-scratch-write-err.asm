; 24-from-scratch-write-err.asm (from scratch)
;
; Try to write to an invalid handle, detect error, exit 1.
;
; Task: Call WriteFile with handle = INVALID_HANDLE_VALUE (-1),
;       check return value (should be 0 = failure), exit 1.
;
; Hint: WriteFile returns 0 on error. Check return value in EAX.

.DATA
message DB "Test"
message_len EQU $ - message
bytesWritten DWORD ?

.CODE

EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub     rsp, 40
    .allocstack 40
    .endprolog
    
    ; TODO: WriteFile(INVALID_HANDLE_VALUE, message, message_len, &bytesWritten, NULL)
    
    ; TODO: Check for error (return 0), exit 1
    
    mov     ecx, 1
    mov ecx, 1
    call ExitProcess
main ENDP

END
