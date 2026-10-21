; Exercise 19: debug aabb y
;
; BUG: used x test for y. Fix overlap on y; exit 1 for overlap.
;
; Build: ml64 /c 19-debug-aabb-y.asm && link /OUT:19-debug-aabb-y.exe /ENTRY:main /SUBSYSTEM:CONSOLE 19-debug-aabb-y.obj kernel32.lib
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    ; a.y=0 a.h=2; b.y=1 b.h=2 overlap
    mov rcx, 1
    call ExitProcess
main ENDP
END
