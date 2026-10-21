; Listing 12: Stack alignment with shadow + 8 (LESSON.md asm block 12)
;
; Purpose: Allocate 40 bytes before a nested call so RSP is 16-byte aligned at `call`.
; Expected exit: 0
; Expected stdout: (none)
;
; Build: ml64 /c /Fo12-callee-stack-alignment-40.obj 12-callee-stack-alignment-40.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:12-callee-stack-alignment-40.exe 12-callee-stack-alignment-40.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

SomeOtherFunc PROC
    ret
SomeOtherFunc ENDP

myFunc PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    call SomeOtherFunc
    add rsp, 40
    ret
myFunc ENDP

main PROC FRAME
    sub rsp, 32
    .allocstack 32
    .endprolog
    call myFunc
    xor ecx, ecx
    call ExitProcess
main ENDP

END
