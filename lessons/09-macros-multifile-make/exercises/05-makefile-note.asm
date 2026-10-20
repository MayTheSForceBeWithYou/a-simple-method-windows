; 05-makefile-note.asm
; Single file, exit 0. Comment mentions multi-file build.
; Task: Simple exit 0 with comment about build process.

.CODE
EXTRN ExitProcess:PROC

; Build: ml64 /c FILE.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE FILE.obj kernel32.lib

main PROC
    ; TODO: xor ecx, ecx; call ExitProcess
    .ERR <TODO: Exit 0>
main ENDP
END
