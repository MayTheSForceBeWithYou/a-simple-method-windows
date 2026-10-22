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
EXTRN ex_10_open_dev_null:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_10_open_dev_null in this file.
    call    ex_10_open_dev_null
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
