; Exercise 23: sib full
;
; base=addr of table, index=2, scale=8, disp=0. table QWORD 0,0,42,0. Load into rcx.
;
; Build: ml64 /c 23-sib-full.asm && link /OUT:23-sib-full.exe /ENTRY:main /SUBSYSTEM:CONSOLE 23-sib-full.obj kernel32.lib
;
; Expected exit: 42

EXTERN ExitProcess:PROC

.data
table QWORD 0, 0, 42, 0

.code
main PROC
    sub rsp, 40
    lea rbx, [table]
    mov r8, 2
    mov rcx, QWORD PTR [rbx+r8*8]
    call ExitProcess
main ENDP
END
