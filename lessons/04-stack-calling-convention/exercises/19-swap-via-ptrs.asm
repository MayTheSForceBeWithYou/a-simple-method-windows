; Exercise: 19-swap-via-ptrs
;
; swap(&a,&b). a=1,b=2; after swap exit a (2). MS x64 ABI.
;
; Contract: implement `ex_19_swap_via_ptrs` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_19_swap_via_ptrs:PROC

; TODO: write ex_19_swap_via_ptrs in this file.

main PROC
    sub     rsp, 40
    call    ex_19_swap_via_ptrs
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
