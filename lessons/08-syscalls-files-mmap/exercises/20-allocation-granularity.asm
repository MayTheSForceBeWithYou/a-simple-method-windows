; Exercise: 20-allocation-granularity
;
; Fill first 16 bytes of VirtualAlloc with 1; sum=16; exit 16.
;
; Contract: implement `ex_20_allocation_granularity` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 16
;
.CODE

EXTRN VirtualAlloc:PROC
EXTRN VirtualFree:PROC
EXTRN ExitProcess:PROC
EXTERNDEF ex_20_allocation_granularity:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_20_allocation_granularity in this file.
    call    ex_20_allocation_granularity
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
