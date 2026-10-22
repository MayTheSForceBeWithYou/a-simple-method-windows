; Exercise: 22-euler-multiples-unroll
;
; Exercise 22: euler multiples unroll
; Project-Euler-lite: sum of multiples of 3 or 5 below 20 (unrolled/constant). Answer 78. Exit 78.
;
; Contract: implement `ex_22_euler_multiples_unroll` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 78
;

; Exercise 22: euler multiples unroll
;
; Project-Euler-lite: sum of multiples of 3 or 5 below 20 (unrolled/constant). Answer 78. Exit 78.
;
; Build: ml64 /c 22-euler-multiples-unroll.asm && link /OUT:22-euler-multiples-unroll.exe /ENTRY:main /SUBSYSTEM:CONSOLE 22-euler-multiples-unroll.obj kernel32.lib
;
; Expected exit: 78


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_22_euler_multiples_unroll:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_22_euler_multiples_unroll in this file.
    call    ex_22_euler_multiples_unroll
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
