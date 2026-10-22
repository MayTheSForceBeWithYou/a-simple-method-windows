; Exercise 05: makefile note
;
; Single-file stand-in: exit 0. (Real multi-file would use build script.)
;
; Build: ml64 /c 05-makefile-note.asm && link /OUT:05-makefile-note.exe /ENTRY:main /SUBSYSTEM:CONSOLE 05-makefile-note.obj kernel32.lib
;
; Expected exit: 0

EXTERN ExitProcess:PROC

; When expanding: ml64 /c a.asm b.asm && link a.obj b.obj /OUT:prog.exe /ENTRY:main /SUBSYSTEM:CONSOLE kernel32.lib

.code
ex_05_makefile_note PROC
    sub rsp, 40
        mov     eax, 0
    ret

ex_05_makefile_note ENDP
main PROC
    call    ex_05_makefile_note
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
