; Exercise 01: buffer init
;
; Allocate 64 byte buffer; store length 0 in len; exit len.
;
; Build: ml64 /c 01-buffer-init.asm && link /OUT:01-buffer-init.exe /ENTRY:main /SUBSYSTEM:CONSOLE 01-buffer-init.obj kernel32.lib
;
; Expected exit: 0

EXTERN ExitProcess:PROC

.data?
buf BYTE 64 DUP(?)
len QWORD ?

.code
main PROC
    sub rsp, 32
    
    mov QWORD PTR [len], 0
    mov rcx, [len]
    call ExitProcess
main ENDP
END
