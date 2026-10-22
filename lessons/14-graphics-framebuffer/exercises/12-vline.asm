; Exercise: 12-vline
;
; Exercise 12: vline
; Vertical with stride 4; plot 3 pixels; sum=6 if value 2.
; Expected stdout: (none)
;
; Contract: implement `ex_12_vline` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 6
;

; 12-vline: vline
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_12_vline:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_12_vline in this file.
    call    ex_12_vline
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
