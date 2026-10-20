; Exercise 12: aabb minkowski
;
; Minkowski expand by 1; width 4->6; exit 6.
;
; Build: ml64 /c 12-aabb-minkowski.asm && link /OUT:12-aabb-minkowski.exe /ENTRY:main /SUBSYSTEM:CONSOLE 12-aabb-minkowski.obj kernel32.lib
;
; Expected exit: 6
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rcx, 4
    add rcx, 2
    call ExitProcess
main ENDP
END
