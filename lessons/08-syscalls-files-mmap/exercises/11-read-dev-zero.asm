; 11-read-dev-zero.asm
;
; Open NUL device, read 8 bytes (all zeros), exit 0.
;
; Task: CreateFileA("NUL", GENERIC_READ, ...), ReadFile 8 bytes, exit 0.
;       Do NOT sum the bytes, just verify read succeeds.
;
; Hint: NUL on Windows acts like /dev/zero for reads (returns zeros).

.DATA
filename DB "NUL", 0
buffer DB 8 DUP(?)
bytesRead DWORD ?

.CODE

EXTRN CreateFileA:PROC
EXTRN ReadFile:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    sub     rsp, 48
    .allocstack 48
    .endprolog
    
    ; TODO: CreateFileA, ReadFile 8 bytes, CloseHandle
    
    xor     ecx, ecx
    call    ExitProcess

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
