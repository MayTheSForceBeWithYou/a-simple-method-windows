; Exercise: 14-sar-vs-shr
;
; For -4: sar 1 vs shr 1; exit (sar_result == -2) as 1.
;
; Contract: implement `ex_14_sar_vs_shr` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_14_sar_vs_shr:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_14_sar_vs_shr in this file.
    call    ex_14_sar_vs_shr
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
