; 08-from-scratch-close.asm (from scratch)
;
; Open NUL device, close it, exit 0.
;
; Task: CreateFileA("NUL", GENERIC_READ, ..., OPEN_EXISTING, ...),
;       CloseHandle, exit 0.
;
; Hint: "NUL" is Windows null device (like /dev/null or /dev/zero).

.DATA
filename DB "NUL", 0

.CODE

EXTRN CreateFileA:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC
EXTRN ex_08_from_scratch_close:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_08_from_scratch_close in this file.
    call    ex_08_from_scratch_close
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
