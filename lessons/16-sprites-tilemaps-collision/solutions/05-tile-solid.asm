; Exercise 05: tile solid
;
; tile id 2 solid table; exit 1.
;
; Build: ml64 /c 05-tile-solid.asm && link /OUT:05-tile-solid.exe /ENTRY:main /SUBSYSTEM:CONSOLE 05-tile-solid.obj kernel32.lib
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
solid BYTE 0,0,1,0

.code
main PROC
    sub rsp, 32
    movzx rcx, BYTE PTR [solid+2]
    call ExitProcess
main ENDP
END
