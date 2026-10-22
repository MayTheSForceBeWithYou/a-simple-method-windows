; Exercise: 14-dirty-flag
;
; Edit sets dirty=1; save clears; exit dirty 0.
;
; Contract: implement `ex_14_dirty_flag` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.DATA?
dirty QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_14_dirty_flag:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_14_dirty_flag in this file.
    call    ex_14_dirty_flag
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
