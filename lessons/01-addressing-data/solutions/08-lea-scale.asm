; Exercise 08: lea scale
;
; Without memory load: rbx=100, r8=3. lea rcx,[rbx+r8*4] (112), exit.
;
; Build: ml64 /c 08-lea-scale.asm && link /OUT:08-lea-scale.exe /ENTRY:main /SUBSYSTEM:CONSOLE 08-lea-scale.obj kernel32.lib
;
; Expected exit: 112

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rbx, 100
    mov r8, 3
    lea rcx, [rbx+r8*4]
    call ExitProcess
main ENDP
END
