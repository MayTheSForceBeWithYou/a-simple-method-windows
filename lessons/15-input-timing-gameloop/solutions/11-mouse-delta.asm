; Exercise 11: mouse delta
;
; dx=5 dy=-2; manhattan 7; exit 7.
;
; Build: ml64 /c 11-mouse-delta.asm && link /OUT:11-mouse-delta.exe /ENTRY:main /SUBSYSTEM:CONSOLE 11-mouse-delta.obj kernel32.lib
;
; Expected exit: 7
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code

ex_11_mouse_delta PROC
mov rax, 5
    mov rbx, -2
    neg rbx
    add rax, rbx
    mov rcx, rax

    ret
ex_11_mouse_delta ENDP
main PROC
    sub     rsp, 40
    call    ex_11_mouse_delta
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
