; Exercise: 07-write-iov-lite
;
; Two writes simulating writev; print 'A\nB\n'; exit 0.
; Expected stdout: "A\nB\n"
;
; Contract: implement `ex_07_write_iov_lite` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.DATA
buf1 DB "Part1", 13, 10
buf1_len EQU $ - buf1
buf2 DB "Part2", 13, 10
buf2_len EQU $ - buf2
bytesWritten DWORD ?

.CODE

EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC
EXTRN ex_07_write_iov_lite:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_07_write_iov_lite in this file.
    call    ex_07_write_iov_lite
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
