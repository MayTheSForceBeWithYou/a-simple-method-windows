; Exercise: 09-q16-from-int
;
; Convert 5 to Q16.16; >>16 back exit 5.
;
; Contract: implement `ex_09_q16_from_int` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 5
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_09_q16_from_int:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_09_q16_from_int in this file.
    call    ex_09_q16_from_int
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
