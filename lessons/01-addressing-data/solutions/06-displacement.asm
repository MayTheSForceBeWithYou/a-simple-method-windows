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

ex_06_displacement PROC
mov rcx, QWORD PTR [vals+16]
    mov     eax, ecx
    ret
ex_06_displacement ENDP
main PROC
    sub     rsp, 40
    call    ex_06_displacement
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
