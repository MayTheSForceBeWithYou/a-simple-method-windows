; Exercise: 24-from-scratch-kill-line
;
; FROM SCRATCH: "ab\ncd" kill from cur=0 to newline -> len becomes 3 ("\ncd"); exit 3.
;
; Contract: implement `ex_24_from_scratch_kill_line` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.DATA?
buf DB 256 DUP(?)
len QWORD ?
cur QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_24_from_scratch_kill_line:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_24_from_scratch_kill_line in this file.
    call    ex_24_from_scratch_kill_line
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
