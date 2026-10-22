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
EXTRN ex_11_read_dev_zero:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_11_read_dev_zero (student routine; defined in solutions/).
    call    ex_11_read_dev_zero
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
