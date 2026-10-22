; Exercise: 22-is-prime-lite
;
; Trial divide n=11 by 2..sqrt-ish (2..10). Exit 1 if prime else 0.
;
; Contract: implement `ex_22_is_prime_lite` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_22_is_prime_lite:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_22_is_prime_lite in this file.
    call    ex_22_is_prime_lite
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
