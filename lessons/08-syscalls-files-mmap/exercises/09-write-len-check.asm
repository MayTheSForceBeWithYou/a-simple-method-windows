; Exercise: 09-write-len-check
;
; Exercise 09: write len check
; write "Z\n"; if written==2 exit 0 else 1.
; Expected stdout: "Z\n"
;
; Contract: implement `ex_09_write_len_check` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;

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
    ; TODO: write ex_09_write_len_check in this file.
    call    ex_09_write_len_check
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
