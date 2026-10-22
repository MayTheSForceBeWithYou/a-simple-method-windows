; Listing 16: main calls helper_add (LESSON.md block 16)
;
; Expected exit: 42
; Expected stdout: (none)
;
; ml64 /c 14-helper-add.asm && ml64 /c 16-main-call-helper.asm && link ...

.CODE
EXTRN helper_add:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    mov rcx, 20
    mov rdx, 22
    call helper_add
    mov ecx, eax
    call ExitProcess
main ENDP

END
