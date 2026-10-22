; 04-plot-stub: plot stub
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_04_plot_stub:PROC
main PROC
    ; TODO: write ex_04_plot_stub in this file.
    call    ex_04_plot_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
