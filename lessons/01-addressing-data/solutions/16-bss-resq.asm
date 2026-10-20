; Exercise 16: bss resq
;
; QWORD ? DUP(4). Store 1,2,3,4 into consecutive qwords; sum into rcx (10); exit.
;
; Build: ml64 /c 16-bss-resq.asm && link /OUT:16-bss-resq.exe /ENTRY:main /SUBSYSTEM:CONSOLE 16-bss-resq.obj kernel32.lib
;
; Expected exit: 10

EXTERN ExitProcess:PROC

.data?
arr QWORD 4 DUP(?)

.code
main PROC
    sub rsp, 32
    mov QWORD PTR [arr], 1
    mov QWORD PTR [arr+8], 2
    mov QWORD PTR [arr+16], 3
    mov QWORD PTR [arr+24], 4
    mov rcx, [arr]
    add rcx, [arr+8]
    add rcx, [arr+16]
    add rcx, [arr+24]
    call ExitProcess
main ENDP
END
