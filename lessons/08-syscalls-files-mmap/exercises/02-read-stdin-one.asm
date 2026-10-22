; 02-read-stdin-one.asm
;
; Read one byte from stdin, exit with that byte value (or 0 at EOF).
;
; Task: Get stdin handle, call ReadFile for 1 byte, exit with the byte value.
;       If EOF (bytesRead == 0), exit 0.
;
; Hint: GetStdHandle(-10) for STD_INPUT_HANDLE.
;       ReadFile returns nonzero on success, check bytesRead for count.

.DATA
buffer DB ?
bytesRead DWORD ?

.CODE

EXTRN GetStdHandle:PROC
EXTRN ReadFile:PROC
EXTRN ExitProcess:PROC
EXTRN ex_02_read_stdin_one:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_02_read_stdin_one in this file.
    call    ex_02_read_stdin_one
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
