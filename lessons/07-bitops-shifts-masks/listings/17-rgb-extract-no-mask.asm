; Listing 17: RGB extract without mask (wrong reading from LESSON.md)
;
; Purpose: Shows why you must mask after shifting when high bits are set.
; Expected exit: 65451
; Expected stdout: (none)
;
; Build: ml64 /c /Fo17-rgb-extract-no-mask.obj 17-rgb-extract-no-mask.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:17-rgb-extract-no-mask.exe 17-rgb-extract-no-mask.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog

    mov rax, 0FFABCDEFh        ; Bits above bit 23 pollute a bare shr

    mov rbx, rax
    shr rbx, 16                ; Red field shifted down — MISSING and rbx, 0FFh

    mov ecx, ebx               ; Exit with polluted "red" low bits
    call ExitProcess
main ENDP

END
