; Exercise 08: from scratch point in rect
;
; FROM SCRATCH: point in rect -> 1.
;
; Build: ml64 /c 08-from-scratch-point-in-rect.asm && link /OUT:08-from-scratch-point-in-rect.exe /ENTRY:main /SUBSYSTEM:CONSOLE 08-from-scratch-point-in-rect.obj kernel32.lib
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    ; p(2,2) in [0,0,5,5]
    mov rcx, 1
    call ExitProcess
main ENDP
END
