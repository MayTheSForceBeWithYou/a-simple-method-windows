; Exercise 04: delete backspace
;
; len=2; backspace; exit len 1.
;
; Build: ml64 /c 04-delete-backspace.asm && link /OUT:04-delete-backspace.exe /ENTRY:main /SUBSYSTEM:CONSOLE 04-delete-backspace.obj kernel32.lib
;
; Expected exit: 1

EXTERN ExitProcess:PROC

.data?
len QWORD ?

.code
main PROC
    sub rsp, 40
    
    mov QWORD PTR [len], 2
    cmp QWORD PTR [len], 0
    je L_o
    dec QWORD PTR [len]
    
L_o:
    mov rcx, [len]
    call ExitProcess
main ENDP
END
