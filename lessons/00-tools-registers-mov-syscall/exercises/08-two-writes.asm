; Exercise: 08-two-writes
;
; Write "alpha\n" then "beta\n" with two WriteFile calls. Exit 0.
;
; Contract: implement `ex_08_two_writes` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.DATA
msg1 DB "Line one", 13, 10
msg1_len EQU $ - msg1
msg2 DB "Line two", 13, 10
msg2_len EQU $ - msg2

.DATA?
bytes_written DQ ?

.CODE

EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC
EXTERNDEF ex_08_two_writes:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_08_two_writes in this file.
    call    ex_08_two_writes
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
