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

main PROC FRAME
    sub     rsp, 40
    .allocstack 40
    .endprolog
    
    ; TODO: Get stdin handle
    .ERR <TODO: Call GetStdHandle with STD_INPUT_HANDLE (-10)>
    
    ; TODO: ReadFile(stdin, &buffer, 1, &bytesRead, NULL)
    .ERR <TODO: Call ReadFile to read 1 byte>
    
    ; TODO: Check if bytesRead == 0 (EOF), exit 0; else exit with buffer byte
    .ERR <TODO: Load buffer byte into exit code>
    
    add     rsp, 40
    call    ExitProcess
main ENDP

END
