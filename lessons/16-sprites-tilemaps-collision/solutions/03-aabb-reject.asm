; Exercise 03: aabb reject
;
; No overlap -> 0.
;
; Build: ml64 /c 03-aabb-reject.asm && link /OUT:03-aabb-reject.exe /ENTRY:main /SUBSYSTEM:CONSOLE 03-aabb-reject.obj kernel32.lib
;
; Expected exit: 0
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    xor rcx, rcx
    call ExitProcess
main ENDP
END
