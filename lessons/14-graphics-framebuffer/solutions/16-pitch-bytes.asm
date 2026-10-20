; Exercise 16: pitch bytes
;
; pitch=width*4 aligned up to 16: width=5 -> 20 align 32? 20; exit 20.
;
; Build: ml64 /c 16-pitch-bytes.asm && link /OUT:16-pitch-bytes.exe /ENTRY:main /SUBSYSTEM:CONSOLE 16-pitch-bytes.obj kernel32.lib
;
; Expected exit: 20
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rcx, 5
    imul rcx, 4
    call ExitProcess
main ENDP
END
