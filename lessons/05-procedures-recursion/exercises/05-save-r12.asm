; Exercise 05: save r12 (Win32 port)
; Use R12 in callee; must push/pop. Caller expects R12=42 still; exit 42.
; Build: ml64 /c /Fo05-save-r12.obj 05-save-r12.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:05-save-r12.exe 05-save-r12.obj kernel32.lib
; Expected: exit code 42

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement function that uses R12 but preserves it

main PROC
    sub     rsp, 32
    mov r12, 42
    call use_r12
    mov rcx, r12               ; Should still be 42
    call ExitProcess
main ENDP
END
