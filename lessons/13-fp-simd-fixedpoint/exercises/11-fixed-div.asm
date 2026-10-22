; Exercise: 11-fixed-div
;
; Q16: (6<<16)/(2<<16) via (a<<16)/b style: ((6<<16)<<16)/(2<<16) careful. Simpler int: 6/2=3 exit 3.
;
; Contract: implement `ex_11_fixed_div` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_11_fixed_div:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_11_fixed_div in this file.
    call    ex_11_fixed_div
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
