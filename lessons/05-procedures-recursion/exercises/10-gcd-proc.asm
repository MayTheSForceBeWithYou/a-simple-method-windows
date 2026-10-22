; Exercise: 10-gcd-proc
;
; Exercise 10: gcd proc
; gcd(48,18)=6 Euclid recursive.
;
; Contract: implement `ex_10_gcd_proc` (MS x64). Return exit code in EAX.
; Expected exit: 6
;

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_10_gcd_proc:PROC

; TODO: write ex_10_gcd_proc in this file.

main PROC
    sub     rsp, 40
    call    ex_10_gcd_proc
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
