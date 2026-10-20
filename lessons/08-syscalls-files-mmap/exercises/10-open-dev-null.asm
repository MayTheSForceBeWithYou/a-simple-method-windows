; 10-open-dev-null.asm
;
; Open NUL device for writing, close it, exit 0.
;
; Task: CreateFileA("NUL", GENERIC_WRITE, ..., OPEN_EXISTING, ...),
;       CloseHandle, exit 0.
;
; Hint: Similar to exercise 08, but with GENERIC_WRITE.

.DATA
filename DB "NUL", 0

.CODE

EXTRN CreateFileA:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    sub     rsp, 48
    .allocstack 48
    .endprolog
    
    ; TODO: CreateFileA("NUL", GENERIC_WRITE, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL)
    .ERR <TODO: Call CreateFileA with GENERIC_WRITE (0x40000000)>
    
    ; TODO: Check and close
    .ERR <TODO: Check for error, CloseHandle>
    
    xor     ecx, ecx
    add     rsp, 48
    pop     rbx
    call    ExitProcess
main ENDP

END
