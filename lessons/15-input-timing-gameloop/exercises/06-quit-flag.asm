; Exercise: 06-quit-flag
;
; Exercise 06: quit flag
; quit dq 1; exit quit.
; Expected stdout: (none)
;
; Contract: implement `ex_06_quit_flag` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;

; 06-quit-flag: quit flag
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_06_quit_flag:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_06_quit_flag in this file.
    call    ex_06_quit_flag
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
