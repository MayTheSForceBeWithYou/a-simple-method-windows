; Exercise 14: debug missing ret (Win32 port)
; BUG: function falls through without RET. Fix it. Should exit 3.
; Build: ml64 /c /Fo14-debug-missing-ret.obj 14-debug-missing-ret.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:14-debug-missing-ret.exe 14-debug-missing-ret.obj kernel32.lib
; Expected: exit code 3

.CODE
EXTRN ExitProcess:PROC

get_three PROC
    mov rax, 3
    ; BUG: Missing RET - falls through!
    .ERR <BUG: Add RET instruction>
get_three ENDP

main PROC
    sub rsp, 32
    call get_three
    mov rcx, rax
    call ExitProcess
main ENDP
END
