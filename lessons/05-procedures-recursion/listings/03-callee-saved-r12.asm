; Listing 03: Callee-saved register spill (lines 48-64 of LESSON.md)
;
; Purpose: Function using R12 must preserve it.
; Expected exit code: 42
; Expected output: (none)
;
; Build: ml64 /c /Fo03-callee-saved-r12.obj 03-callee-saved-r12.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-callee-saved-r12.exe 03-callee-saved-r12.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

wipe PROC FRAME
    push r12                   ; Save nonvolatile R12
    .pushreg r12
    sub rsp, 32
    .allocstack 32
    .endprolog
    
    xor r12, r12               ; Use R12 temporarily
    
    add rsp, 32
    pop r12                    ; Restore R12
    ret
wipe ENDP

main PROC
    sub rsp, 40
    mov r12, 42
    call wipe
    mov rcx, r12               ; Still 42 (preserved)
    call ExitProcess
main ENDP

END
