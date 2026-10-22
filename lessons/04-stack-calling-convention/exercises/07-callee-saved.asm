; Exercise 07: callee saved (Win32 port)
;
; Caller puts 9 in RBX. Callee must preserve RBX. Callee uses RBX temporarily but restores. Exit RBX (9).
; RBX is nonvolatile in MS x64.
;
; Build: ml64 /c /Fo07-callee-saved.obj 07-callee-saved.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:07-callee-saved.exe 07-callee-saved.obj kernel32.lib
; Expected: exit code 9

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement helper that uses RBX but preserves it (PUSH/POP)

main PROC FRAME
    push    rbx
    .pushreg rbx
    sub     rsp, 32
    .allocstack 32
    .endprolog
    mov     rbx, 9
    call    helper
    mov     rcx, rbx
    add     rsp, 32
    pop     rbx
    sub     rsp, 32
    call    ExitProcess
main ENDP
END
