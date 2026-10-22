; Exercise: 03-rec-sum
;
; sum_to(n)=n+(n-1)+...+1 recursive. sum_to(5)=15.
;
; Contract: implement `ex_03_rec_sum` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 15
;
; Implement recursive `sum_to(n)`. In `ex_03_rec_sum`, exit sum_to(5)=15.
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_03_rec_sum:PROC

; TODO: write ex_03_rec_sum in this file.

main PROC
    sub     rsp, 40
    call    ex_03_rec_sum
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
