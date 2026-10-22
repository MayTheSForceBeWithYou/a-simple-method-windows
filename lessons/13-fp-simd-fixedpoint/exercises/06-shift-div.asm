; Exercise: 06-shift-div
;
; Divide by 4 via sar; 20>>2=5.
;
; Contract: implement `ex_06_shift_div` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 5
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_06_shift_div:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_06_shift_div in this file.
    call    ex_06_shift_div
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
