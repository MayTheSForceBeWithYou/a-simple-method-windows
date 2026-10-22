; Exercise: 04-edge-trigger
;
; prev=0 cur=1 -> rising exit 1.
; Expected stdout: (none)
;
; Contract: implement `ex_04_edge_trigger` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_04_edge_trigger:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_04_edge_trigger in this file.
    call    ex_04_edge_trigger
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
