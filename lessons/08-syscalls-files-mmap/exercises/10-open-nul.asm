; 10-open-nul.asm
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
EXTRN ex_10_open_nul:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_10_open_nul in this file.
    call    ex_10_open_nul
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
