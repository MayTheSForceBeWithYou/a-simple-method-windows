; Exercise: 28-from-scratch-expr
;
; Exercise 28: from scratch expr
; FROM SCRATCH: exit status = (12*12 - 100) / 4 + 1 = 12. Show work with idiv.
;
; Contract: implement `ex_28_from_scratch_expr` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 12
;

; Exercise 28: from scratch expr
;
; FROM SCRATCH: exit status = (12*12 - 100) / 4 + 1 = 12. Show work with idiv.
;
; Build: ml64 /c 28-from-scratch-expr.asm && link /OUT:28-from-scratch-expr.exe /ENTRY:main /SUBSYSTEM:CONSOLE 28-from-scratch-expr.obj kernel32.lib
;
; Expected exit: 12


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_28_from_scratch_expr:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_28_from_scratch_expr in this file.
    call    ex_28_from_scratch_expr
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
