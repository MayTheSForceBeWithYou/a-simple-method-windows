; Exercise: 14-mutual-parity-count
;
; is_even(6)=1. MS x64 ABI.
;
; Contract: implement `ex_14_mutual_parity_count` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_14_mutual_parity_count:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_14_mutual_parity_count in this file.
    call    ex_14_mutual_parity_count
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
