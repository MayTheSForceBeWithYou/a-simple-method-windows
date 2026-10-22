; Exercise: 22-stretch-undo-stack
;
; STRETCH: push op code 1 then 2; pop once; exit top 1.
;
; Contract: implement `ex_22_stretch_undo_stack` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.DATA?
undo_stack DQ 16 DUP(?)
stack_top QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_undo_stack:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_22_stretch_undo_stack in this file.
    call    ex_22_stretch_undo_stack
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
