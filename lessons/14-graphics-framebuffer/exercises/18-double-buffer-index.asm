; Exercise: 18-double-buffer-index
;
; Exercise 18: double buffer index
; Flip buffer index 0<->1; start 0 flip twice exit 0.
; Expected stdout: (none)
;
; Contract: implement `ex_18_double_buffer_index` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;

; 18-double-buffer-index: double buffer index
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_18_double_buffer_index:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_18_double_buffer_index in this file.
    call    ex_18_double_buffer_index
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
