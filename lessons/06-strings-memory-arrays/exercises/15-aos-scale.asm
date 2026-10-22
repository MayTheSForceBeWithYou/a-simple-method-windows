; Exercise: 15-aos-scale
;
; {3,4}*2 -> {6,8}; sum=14.
;
; Contract: implement `ex_15_aos_scale` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 14
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_15_aos_scale:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_15_aos_scale in this file.
    call    ex_15_aos_scale
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
