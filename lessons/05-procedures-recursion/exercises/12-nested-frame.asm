; Exercise: 12-nested-frame
;
; Exercise 12: nested frame
; outer calls inner. inner returns rcx+rdx. outer adds 1. outer(10,20)=31.
;
; Contract: implement `ex_12_nested_frame` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 31
;

; Exercise 12: 12-nested-frame.asm (Win32 port)
; outer calls inner; both have frames. inner returns rdi+rsi; outer adds 1. Call outer(10,20)->31.
; Build: ml64 /c /Fo12-nested-frame.asm.obj 12-nested-frame.asm.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:12-nested-frame.asm.exe 12-nested-frame.asm.obj kernel32.lib
; Expected: see original exercise

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_12_nested_frame:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_12_nested_frame in this file.
    call    ex_12_nested_frame
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
