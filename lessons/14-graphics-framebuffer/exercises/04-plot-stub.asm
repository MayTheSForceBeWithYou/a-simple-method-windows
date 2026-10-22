; Exercise: 04-plot-stub
;
; Plot color 7 at index 0; exit 7.
; Expected stdout: (none)
;
; Contract: implement `ex_04_plot_stub` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 7
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_04_plot_stub:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_04_plot_stub in this file.
    call    ex_04_plot_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
