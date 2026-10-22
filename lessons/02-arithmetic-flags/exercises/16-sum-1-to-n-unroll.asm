; Exercise: 16-sum-1-to-n-unroll
;
; Exercise 16: sum 1 to n unroll
; Without jumps: sum 1+2+...+8 into rcx (36) using add chain; exit.
;
; Contract: implement `ex_16_sum_1_to_n_unroll` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 36
;

; Exercise 16: sum 1 to n unroll
;
; Without jumps: sum 1+2+...+8 into rcx (36) using add chain; exit.
;
; Build: ml64 /c 16-sum-1-to-n-unroll.asm && link /OUT:16-sum-1-to-n-unroll.exe /ENTRY:main /SUBSYSTEM:CONSOLE 16-sum-1-to-n-unroll.obj kernel32.lib
;
; Expected exit: 36


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_16_sum_1_to_n_unroll:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_16_sum_1_to_n_unroll in this file.
    call    ex_16_sum_1_to_n_unroll
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
