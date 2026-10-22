; Exercise 15: debug wrong arg reg (Win32 port)
; BUG: second arg in wrong register. add(2,40) should=42. Fix MS x64 arg regs.
; Build: ml64 /c /Fo15-debug-wrong-arg-reg.obj 15-debug-wrong-arg-reg.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:15-debug-wrong-arg-reg.exe 15-debug-wrong-arg-reg.obj kernel32.lib
; Expected exit: 42
; Expected stdout: (none)

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_15_debug_wrong_arg_reg:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_15_debug_wrong_arg_reg (student routine; defined in solutions/).
    call    ex_15_debug_wrong_arg_reg
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
