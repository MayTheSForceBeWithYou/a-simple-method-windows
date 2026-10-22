; Exercise 14: debug missing ret (Win32 port)
; BUG: function falls through without RET. Fix it. Should exit 3.
; Build: ml64 /c /Fo14-debug-missing-ret.obj 14-debug-missing-ret.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:14-debug-missing-ret.exe 14-debug-missing-ret.obj kernel32.lib
; Expected exit: 3

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_14_debug_missing_ret:PROC

three PROC
    mov rax, 3
    ; BUG: missing RET — falls through if called
three ENDP

main PROC
    sub     rsp, 40
    ; TODO: write ex_14_debug_missing_ret in this file (call three with a proper RET).
    call    ex_14_debug_missing_ret
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
