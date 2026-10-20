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
.ERR <TODO: Implement helper PROC that preserves RBX>

main PROC
    sub rsp, 32
    mov rbx, 9
    call helper
    mov rcx, rbx               ; Should still be 9
    call ExitProcess
main ENDP
END
