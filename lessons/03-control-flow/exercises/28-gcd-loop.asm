; Exercise 28: gcd loop
;
; Euclid GCD(48,18)=6. Exit 6.
;
; Build: ml64 /c 28-gcd-loop.asm && link /OUT:28-gcd-loop.exe /ENTRY:main /SUBSYSTEM:CONSOLE 28-gcd-loop.obj kernel32.lib
;
; Expected exit: 6


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_28_gcd_loop:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_28_gcd_loop in this file.
    call    ex_28_gcd_loop
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
