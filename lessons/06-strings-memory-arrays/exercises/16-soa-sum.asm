; Exercise: 16-soa-sum
;
; SoA xs={1,2,3} ys={4,5,6}; sum all 21.
; Expected stdout: (none)
;
; Contract: implement `ex_16_soa_sum` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 21
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_16_soa_sum:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_16_soa_sum in this file.
    call    ex_16_soa_sum
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
