; Exercise: 11-read-nul
;
; Exercise 11: read dev zero
; Allocate zero-filled memory with VirtualAlloc; read 8 bytes; sum should be 0; exit 0.
;
; Contract: implement `ex_11_read_nul` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;

; 11-read-nul.asm
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
EXTRN ex_11_read_nul:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_11_read_nul in this file.
    call    ex_11_read_nul
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
