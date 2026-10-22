; Exercise: 24-stretch-variadic-sum
;
; STRETCH: sum_n(n, a,b,c,d) — n in rcx, remaining MS x64 args. sum_n(4,3,4,5,6)=18.
; Expected stdout: (none)
;
; Contract: implement `ex_24_stretch_variadic_sum` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 18
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_24_stretch_variadic_sum:PROC

; TODO: write ex_24_stretch_variadic_sum in this file.

main PROC
    sub     rsp, 40
    call    ex_24_stretch_variadic_sum
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
