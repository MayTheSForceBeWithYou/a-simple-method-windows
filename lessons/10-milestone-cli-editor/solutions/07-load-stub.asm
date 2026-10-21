; Exercise 07: load stub
;
; Pretend load sets len=3; exit 3.
;
; Build: ml64 /c 07-load-stub.asm && link /OUT:07-load-stub.exe /ENTRY:main /SUBSYSTEM:CONSOLE 07-load-stub.obj kernel32.lib
;
; Expected exit: 3

EXTERN ExitProcess:PROC

.data?
len QWORD ?

.code
main PROC
    sub rsp, 40
    
    mov QWORD PTR [len], 3
    mov rcx, [len]
    call ExitProcess
main ENDP
END
