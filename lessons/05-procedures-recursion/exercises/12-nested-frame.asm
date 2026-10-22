; Exercise 12: 12-nested-frame.asm (Win32 port)
; outer calls inner; both have frames. inner returns rdi+rsi; outer adds 1. Call outer(10,20)->31.
; Build: ml64 /c /Fo12-nested-frame.asm.obj 12-nested-frame.asm.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:12-nested-frame.asm.exe 12-nested-frame.asm.obj kernel32.lib
; Expected: see original exercise

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_12_nested_frame:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_12_nested_frame (student routine; defined in solutions/).
    call    ex_12_nested_frame
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
