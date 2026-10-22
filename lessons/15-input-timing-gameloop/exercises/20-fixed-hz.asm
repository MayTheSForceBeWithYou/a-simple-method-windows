; Exercise: 20-fixed-hz
;
; 60 Hz -> step ns approx store 16666667&0FFh; exit low byte or exit 60 as hz.
; Expected stdout: (none)
;
; Contract: implement `ex_20_fixed_hz` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 60
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_fixed_hz:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_20_fixed_hz in this file.
    call    ex_20_fixed_hz
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
