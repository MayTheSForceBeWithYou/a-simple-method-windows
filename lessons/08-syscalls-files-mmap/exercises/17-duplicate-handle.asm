; 17-duplicate-handle.asm
;
; Write to stdout (no DuplicateHandle call needed), exit 0.
;
; Task: Get stdout handle, WriteFile "Dup test\n", exit 0.
;       This demonstrates that you can write to fd 1 equivalent.
;
; Hint: Simple WriteFile to stdout.

.DATA
message DB "Dup test", 13, 10
message_len EQU $ - message
bytesWritten DWORD ?

.CODE

EXTRN ExitProcess:PROC
EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ex_17_duplicate_handle:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_17_duplicate_handle in this file.
    call    ex_17_duplicate_handle
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
