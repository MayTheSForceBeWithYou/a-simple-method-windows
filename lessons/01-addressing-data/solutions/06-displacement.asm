; Exercise 06: displacement
;
; struct-like: base label vals with QWORD 1,2,3. Load third qword via [vals+16] into rcx, exit.
;
; Build: ml64 /c 06-displacement.asm && link /OUT:06-displacement.exe /ENTRY:main /SUBSYSTEM:CONSOLE 06-displacement.obj kernel32.lib
;
; Expected exit: 3

EXTERN ExitProcess:PROC

.data
vals QWORD 1, 2, 3

.code
main PROC
    sub rsp, 40
    mov rcx, QWORD PTR [vals+16]
    call ExitProcess
main ENDP
END
