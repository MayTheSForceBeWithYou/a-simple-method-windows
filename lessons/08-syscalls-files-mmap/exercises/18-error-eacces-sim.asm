; 18-error-eacces-sim.asm
;
; Try to open a directory for writing (should fail with ACCESS_DENIED).
;
; Task: CreateFileA("C:\", GENERIC_WRITE, ..., OPEN_EXISTING, ...),
;       expect failure, GetLastError, exit 1.
;
; Hint: Opening a directory for writing typically fails with ERROR_ACCESS_DENIED (5).

.DATA
path DB "C:\", 0

.CODE

EXTRN CreateFileA:PROC
EXTRN GetLastError:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub     rsp, 56
    .allocstack 56
    .endprolog
    
    ; TODO: Try CreateFileA("C:\", GENERIC_WRITE, ...)
    
    ; TODO: Check for failure, GetLastError, exit 1
    
    mov     ecx, 1
    mov ecx, 1
    call ExitProcess
main ENDP

END
