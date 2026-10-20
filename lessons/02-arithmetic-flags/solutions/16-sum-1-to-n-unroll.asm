; Exercise 16: sum 1 to n unroll
;
; Without jumps: sum 1+2+...+8 into rcx (36) using add chain; exit.
;
; Build: ml64 /c 16-sum-1-to-n-unroll.asm && link /OUT:16-sum-1-to-n-unroll.exe /ENTRY:main /SUBSYSTEM:CONSOLE 16-sum-1-to-n-unroll.obj kernel32.lib
;
; Expected exit: 36

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    xor rcx, rcx
    add rcx, 1
    add rcx, 2
    add rcx, 3
    add rcx, 4
    add rcx, 5
    add rcx, 6
    add rcx, 7
    add rcx, 8
    call ExitProcess
main ENDP
END
