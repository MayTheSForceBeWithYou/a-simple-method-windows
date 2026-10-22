; Exercise 08: lea scale
;
; Without memory load: rbx=100, r8=3. lea rcx,[rbx+r8*4] (112), exit.
;
; Build: ml64 /c 08-lea-scale.asm && link /OUT:08-lea-scale.exe /ENTRY:main /SUBSYSTEM:CONSOLE 08-lea-scale.obj kernel32.lib
;
; Expected exit: 112

EXTERN ExitProcess:PROC

.code

ex_08_lea_scale PROC
mov rbx, 100
    mov r8, 3
    lea rcx, [rbx+r8*4]
    mov     eax, ebx
    ret
ex_08_lea_scale ENDP
main PROC
    sub     rsp, 40
    call    ex_08_lea_scale
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
