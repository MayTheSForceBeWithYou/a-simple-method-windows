; Exercise: 06-path-step
;
; Follow next cell delta x+1; exit 1.
; Expected stdout: (none)
;
; Contract: implement `ex_06_path_step` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_06_path_step:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_06_path_step in this file.
    call    ex_06_path_step
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
