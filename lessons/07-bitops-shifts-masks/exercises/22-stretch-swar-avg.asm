; Exercise: 22-stretch-swar-avg
;
; Implement `ex_22_stretch_swar_avg` in this file.
;
; Contract: implement `ex_22_stretch_swar_avg` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 150
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_swar_avg:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_22_stretch_swar_avg in this file.
    call    ex_22_stretch_swar_avg
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
