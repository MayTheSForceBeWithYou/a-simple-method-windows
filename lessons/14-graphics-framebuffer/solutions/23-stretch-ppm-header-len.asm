; Exercise 23: stretch ppm header len
;
; STRETCH: "P6\n" length 3; exit 3.
;
; Build: ml64 /c 23-stretch-ppm-header-len.asm && link /OUT:23-stretch-ppm-header-len.exe /ENTRY:main /SUBSYSTEM:CONSOLE 23-stretch-ppm-header-len.obj kernel32.lib
;
; Expected exit: 3
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
h BYTE "P6",10

.code
main PROC
    sub rsp, 40
    mov rcx, 3
    call ExitProcess
main ENDP
END
