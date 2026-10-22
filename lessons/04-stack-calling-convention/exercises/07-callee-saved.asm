; Exercise: 07-callee-saved
;
; Caller puts 9 in rbx. Callee must preserve rbx. Exit rbx (9). (rbx is nonvolatile on Windows)
;
; Contract: implement `ex_07_callee_saved` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 9
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_07_callee_saved:PROC

helper PROC
    push rbx
    mov rbx, 123                ; BUG: uses RBX without restoring caller's value
    pop rbx
    ret
helper ENDP

main PROC
    sub     rsp, 40
    ; TODO: write ex_07_callee_saved in this file (RBX must stay 9 after helper).
    call    ex_07_callee_saved
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
