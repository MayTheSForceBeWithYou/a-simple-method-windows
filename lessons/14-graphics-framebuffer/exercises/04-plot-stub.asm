; 04-plot-stub: plot stub
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_04_plot_stub:PROC
main PROC
    ; TODO: implement ex_04_plot_stub (student routine; defined in solutions/).
    call    ex_04_plot_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
