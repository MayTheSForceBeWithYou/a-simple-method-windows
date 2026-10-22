; Exercise 07: panel draw stub
;
; Draw count 3 widgets; exit 3.
;
; Build: ml64 /c 07-panel-draw-stub.asm && link /OUT:07-panel-draw-stub.exe /ENTRY:main /SUBSYSTEM:CONSOLE 07-panel-draw-stub.obj kernel32.lib
;
; Expected exit: 3
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_07_panel_draw_stub PROC
    sub rsp, 40
    mov rcx, 3
    mov     eax, 3
    add     rsp, 40
    ret
ex_07_panel_draw_stub ENDP
main PROC
    sub     rsp, 40
    call    ex_07_panel_draw_stub
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
