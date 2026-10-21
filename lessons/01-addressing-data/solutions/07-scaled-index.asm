; Exercise 07: scaled index
;
; arr QWORD 5,10,15,20. Set r8=2, load arr[r8] with [arr+r8*8] into rcx, exit (15).
;
; Build: ml64 /c 07-scaled-index.asm && link /OUT:07-scaled-index.exe /ENTRY:main /SUBSYSTEM:CONSOLE 07-scaled-index.obj kernel32.lib
;
; Expected exit: 15

EXTERN ExitProcess:PROC

.data
arr QWORD 5, 10, 15, 20

.code
main PROC
    sub rsp, 40
    mov r8, 2
    lea r11, [arr]
    mov rcx, QWORD PTR [r11+r8*8]
    call ExitProcess
main ENDP
END
