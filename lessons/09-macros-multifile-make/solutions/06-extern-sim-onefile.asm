; Exercise 06: extern sim onefile
;
; Simulate two units in one file with helper procedure; exit 5.
;
; Build: ml64 /c 06-extern-sim-onefile.asm && link /OUT:06-extern-sim-onefile.exe /ENTRY:main /SUBSYSTEM:CONSOLE 06-extern-sim-onefile.obj kernel32.lib
;
; Expected exit: 5

EXTERN ExitProcess:PROC

.code
ex_06_extern_sim_onefile PROC
    sub rsp, 40
    call helper
        add     rsp, 40
        ret
ex_06_extern_sim_onefile ENDP
main PROC
    sub     rsp, 40
    call    ex_06_extern_sim_onefile
    mov     rcx, rax
    call    ExitProcess
main ENDP

helper PROC
    mov rax, 5
    ret
helper ENDP
END
