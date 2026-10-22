; Exercise 28: from scratch swap
;
; FROM SCRATCH: a QWORD 1 / b QWORD 2. Swap via registers; exit with rcx=a (should be 2).
;
; Build: ml64 /c 28-from-scratch-swap.asm && link /OUT:28-from-scratch-swap.exe /ENTRY:main /SUBSYSTEM:CONSOLE 28-from-scratch-swap.obj kernel32.lib
;
; Expected exit: 2


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_28_from_scratch_swap:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_28_from_scratch_swap in this file.
    call    ex_28_from_scratch_swap
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
