; 05-errno-neg.asm
;
; Open a missing file, retrieve error code using GetLastError.
;
; Task: Try to open a nonexistent file, check for failure,
;       call GetLastError to get error code, exit with it.
;
; Hint: GetLastError returns DWORD error code in EAX.
;       ERROR_FILE_NOT_FOUND = 2, ERROR_PATH_NOT_FOUND = 3.

.DATA
filename DB "C:\nope.txt", 0

.CODE

EXTRN CreateFileA:PROC
EXTRN GetLastError:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub     rsp, 56
    .allocstack 56
    .endprolog
    
    ; TODO: CreateFileA(filename, GENERIC_READ, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL)
    
    ; TODO: Check for INVALID_HANDLE_VALUE (-1)
    
    ; Failed, get error code
    ; TODO: Call GetLastError
    
    add     rsp, 56
    call    ExitProcess

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
