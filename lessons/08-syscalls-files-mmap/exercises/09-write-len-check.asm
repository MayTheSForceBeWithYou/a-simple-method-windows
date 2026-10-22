; 09-write-len-check.asm
;
; Write a message to stdout, verify bytes written matches expected.
;
; Task: WriteFile "Test\n" (5 bytes), check bytesWritten == 5, exit 0.
;       If mismatch, exit 1.
;
; Hint: Compare bytesWritten with expected length.

.DATA
message DB "Test", 13, 10
message_len EQU $ - message
bytesWritten DWORD ?

.CODE

EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC
EXTRN ex_09_write_len_check:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_09_write_len_check (student routine; defined in solutions/).
    call    ex_09_write_len_check
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
