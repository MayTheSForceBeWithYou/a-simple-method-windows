; Exercise: 22-is-prime-lite
;
; Exercise 22: is prime lite
; Trial divide n=11 by 2..sqrt-ish (2..10). Exit 1 if prime else 0.
;
; Contract: implement `ex_22_is_prime_lite` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;

; Exercise 22: is prime lite
;
; Trial divide n=11 by 2..sqrt-ish (2..10). Exit 1 if prime else 0.
;
; Build: ml64 /c 22-is-prime-lite.asm && link /OUT:22-is-prime-lite.exe /ENTRY:main /SUBSYSTEM:CONSOLE 22-is-prime-lite.obj kernel32.lib
;
; Expected exit: 1


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_22_is_prime_lite:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_22_is_prime_lite in this file.
    call    ex_22_is_prime_lite
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
