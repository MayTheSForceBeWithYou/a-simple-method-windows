; Exercise 14: debug missing ret (Win32 port)
; BUG: function falls through without RET. Fix it. Should exit 3.
; Build: ml64 /c /Fo14-debug-missing-ret.obj 14-debug-missing-ret.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:14-debug-missing-ret.exe 14-debug-missing-ret.obj kernel32.lib
; Expected: exit code 3

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_14_debug_missing_ret:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_14_debug_missing_ret (student routine; defined in solutions/).
    call    ex_14_debug_missing_ret
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
