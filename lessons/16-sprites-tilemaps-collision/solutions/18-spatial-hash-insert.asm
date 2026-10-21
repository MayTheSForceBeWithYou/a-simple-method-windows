; Exercise 18: spatial hash insert
;
; Insert entity into cell bucket count++; exit 1.
;
; Build: ml64 /c 18-spatial-hash-insert.asm && link /OUT:18-spatial-hash-insert.exe /ENTRY:main /SUBSYSTEM:CONSOLE 18-spatial-hash-insert.obj kernel32.lib
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data?
count QWORD ?

.code
main PROC
    sub rsp, 40
    inc QWORD PTR [count]
    mov rcx, [count]
    call ExitProcess
main ENDP
END
