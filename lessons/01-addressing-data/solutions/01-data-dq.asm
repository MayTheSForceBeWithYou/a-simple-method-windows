; Exercise 01: data dq
;
; Define count QWORD 41 in .data. Load into rcx, add 1, exit (42).
;
; Build: ml64 /c 01-data-dq.asm && link /OUT:01-data-dq.exe /ENTRY:main /SUBSYSTEM:CONSOLE 01-data-dq.obj kernel32.lib
;
; Expected exit: 42

EXTERN ExitProcess:PROC

.data
count QWORD 41

.code
main PROC
    sub rsp, 32
    mov rcx, [count]
    add rcx, 1
    call ExitProcess
main ENDP
END
