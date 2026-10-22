; 05-makefile-note.asm
; Single file, exit 0. Comment mentions multi-file build.
; Task: Simple exit 0 with comment about build process.

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_05_makefile_note:PROC

; Build: ml64 /c FILE.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE FILE.obj kernel32.lib

main PROC
    sub     rsp, 40
    ; TODO: return 0 from ex_05_makefile_note (document multi-file build in comments).
    call    ex_05_makefile_note
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
