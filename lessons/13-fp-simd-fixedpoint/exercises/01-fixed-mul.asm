; Exercise: 01-fixed-mul
;
; Q16.16: 2.0 * 3.0 -> 6.0; represent 2<<16 etc; result>>16 exit 6.
;
; Contract: implement `ex_01_fixed_mul` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 6
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_01_fixed_mul:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_01_fixed_mul in this file.
    call    ex_01_fixed_mul
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
