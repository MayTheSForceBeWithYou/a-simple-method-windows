; Exercise 02: call ret leaf (Win32 port)
;
; Write leaf function answer() that returns 42 in RAX. Call it; exit with that.
;
; Build: ml64 /c /Fo02-call-ret-leaf.obj 02-call-ret-leaf.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-call-ret-leaf.exe 02-call-ret-leaf.obj kernel32.lib
; Expected: exit code 42

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement answer() function that returns 42 in RAX

main PROC
    sub     rsp, 32
    call answer
    mov rcx, rax
    call ExitProcess
main ENDP
END
