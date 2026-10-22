; Exercise: 11-hline
;
; Horizontal line y=0 x=0..2 set 1; sum first 3=3.
; Expected stdout: (none)
;
; Contract: implement `ex_11_hline` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_11_hline:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_11_hline in this file.
    call    ex_11_hline
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
