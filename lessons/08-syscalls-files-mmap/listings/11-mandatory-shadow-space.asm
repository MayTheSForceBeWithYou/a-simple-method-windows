; Listing 11: Mandatory 32-byte shadow before ExitProcess (LESSON.md asm block 11)
;
; Purpose: Even a one-argument import needs home space on the stack.
; Expected exit: 0
; Expected stdout: (none)
;
; Build: ml64 /c /Fo11-mandatory-shadow-space.obj 11-mandatory-shadow-space.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:11-mandatory-shadow-space.exe 11-mandatory-shadow-space.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog

    xor ecx, ecx
    call ExitProcess
main ENDP

END
