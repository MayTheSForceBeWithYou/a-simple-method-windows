; 01-write-only.asm
;
; Write two messages to stdout and exit 0.
;
; Task: Use WriteFile twice to write "Hello\n" and "World\n" to stdout (STD_OUTPUT_HANDLE).
;       Exit with code 0.
;
; Hint: Get stdout handle with GetStdHandle(-11).
;       WriteFile needs: handle, buffer, count, &bytesWritten, NULL.

.DATA
msg1 DB "Hello", 13, 10
msg1_len EQU $ - msg1
msg2 DB "World", 13, 10
msg2_len EQU $ - msg2
bytesWritten DWORD ?

.CODE

EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub     rsp, 40
    .allocstack 40
    .endprolog
    
    ; TODO: Get stdout handle
    .ERR <TODO: Call GetStdHandle with STD_OUTPUT_HANDLE (-11)>
    
    ; TODO: WriteFile msg1
    .ERR <TODO: WriteFile(stdout, msg1, msg1_len, &bytesWritten, NULL)>
    
    ; TODO: WriteFile msg2
    .ERR <TODO: WriteFile(stdout, msg2, msg2_len, &bytesWritten, NULL)>
    
    xor     ecx, ecx
    add     rsp, 40
    call    ExitProcess
main ENDP

END
