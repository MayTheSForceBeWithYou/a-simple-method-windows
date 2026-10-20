; 17-dup-concept.asm
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

EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub     rsp, 40
    .allocstack 40
    .endprolog
    
    ; TODO: Get stdout, WriteFile message, exit 0
    .ERR <TODO: GetStdHandle(-11), WriteFile, exit 0>
    
    xor     ecx, ecx
    add     rsp, 40
    call    ExitProcess
main ENDP

END
