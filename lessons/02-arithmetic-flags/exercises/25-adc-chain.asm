; Exercise: 25-adc-chain
;
; Add two 128-bit values lo/hi: a=(1,0) b=(0FFFFFFFFFFFFFFFFh,0). Use add/adc. Exit with CF after adc (1) via setc.
;
; Contract: implement `ex_25_adc_chain` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_25_adc_chain:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_25_adc_chain in this file.
    call    ex_25_adc_chain
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
