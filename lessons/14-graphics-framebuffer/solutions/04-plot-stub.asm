; Exercise 04: plot stub
;
; Plot color 7 at index 0; exit 7.
;
; Build: ml64 /c 04-plot-stub.asm && link /OUT:04-plot-stub.exe /ENTRY:main /SUBSYSTEM:CONSOLE 04-plot-stub.obj kernel32.lib
;
; Expected exit: 7
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data?
fb BYTE 16 DUP(?)

.code

ex_04_plot_stub PROC
sub rsp, 40
    mov BYTE PTR [fb], 7
    movzx rcx, BYTE PTR [fb]
    mov     eax, 7
    ret
ex_04_plot_stub ENDP
main PROC
    sub     rsp, 40
    call    ex_04_plot_stub
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
