; 05-makefile-note.asm
; Single file, exit 0. Comment mentions multi-file build.
; Task: Simple exit 0 with comment about build process.

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_05_makefile_note:PROC

; Build: ml64 /c FILE.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE FILE.obj kernel32.lib

main PROC
    ; TODO: xor ecx, ecx; mov ecx, 1
    ; TODO: implement ex_05_makefile_note (student routine; defined in solutions/).
    call    ex_05_makefile_note
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
