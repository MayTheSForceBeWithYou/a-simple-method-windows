; Exercise 16: debug callee clobber (Win32 port)
; BUG: callee clobbers RBX without saving. Fix by adding PUSH/POP. Exit 11.
; Build: ml64 /c /Fo16-debug-callee-clobber.obj 16-debug-callee-clobber.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:16-debug-callee-clobber.exe 16-debug-callee-clobber.obj kernel32.lib
; Expected: exit code 11

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_16_debug_callee_clobber:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_16_debug_callee_clobber (student routine; defined in solutions/).
    call    ex_16_debug_callee_clobber
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
