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
EXTRN ex_24_from_scratch_write_err:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_24_from_scratch_write_err in this file.
    call    ex_24_from_scratch_write_err
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
