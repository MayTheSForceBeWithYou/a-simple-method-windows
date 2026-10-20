; Exercise 22: euler multiples unroll
;
; Project-Euler-lite: sum of multiples of 3 or 5 below 20 (unrolled/constant). Answer 78. Exit 78.
;
; Build: ml64 /c 22-euler-multiples-unroll.asm && link /OUT:22-euler-multiples-unroll.exe /ENTRY:main /SUBSYSTEM:CONSOLE 22-euler-multiples-unroll.obj kernel32.lib
;
; Expected exit: 78

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rcx, 78
    call ExitProcess
main ENDP
END
