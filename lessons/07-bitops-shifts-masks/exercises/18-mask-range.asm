; Exercise: 18-mask-range
;
; Implement `ex_18_mask_range` in this file.
;
; Contract: implement `ex_18_mask_range` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 31
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_18_mask_range:PROC

main PROC
    sub     rsp, 40
    ; TODO: Compute mask with bits 2-5 set
    
    ; TODO: write ex_18_mask_range in this file.
    call    ex_18_mask_range
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
