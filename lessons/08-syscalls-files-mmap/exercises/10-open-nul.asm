; Exercise: 10-open-nul
;
; Exercise 10: open dev null
; open NUL (Windows null device) write-only; on success close and exit 0.
;
; Contract: implement `ex_10_open_nul` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;

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
