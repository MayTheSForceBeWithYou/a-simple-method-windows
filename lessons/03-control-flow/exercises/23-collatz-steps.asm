; Exercise 23: collatz steps
;
; Collatz steps for n=6 until 1: 6->3->10->5->16->8->4->2->1 = 8 steps. Exit 8.
;
; Build: ml64 /c 23-collatz-steps.asm && link /OUT:23-collatz-steps.exe /ENTRY:main /SUBSYSTEM:CONSOLE 23-collatz-steps.obj kernel32.lib
;
; Expected exit: 8


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_23_collatz_steps:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_23_collatz_steps in this file.
    call    ex_23_collatz_steps
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
