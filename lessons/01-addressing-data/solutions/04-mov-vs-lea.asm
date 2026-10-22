; Exercise 04: mov vs lea
;
; Label x QWORD 99. lea rbx,[x] then mov rcx,[rbx]. Exit with 99. Comment which is address vs load.
;
; Build: ml64 /c 04-mov-vs-lea.asm && link /OUT:04-mov-vs-lea.exe /ENTRY:main /SUBSYSTEM:CONSOLE 04-mov-vs-lea.obj kernel32.lib
;
; Expected exit: 99

EXTERN ExitProcess:PROC

.data
x QWORD 99

.code

ex_04_mov_vs_lea PROC
lea rbx, [x]        ; rbx = address of x
    mov rcx, [rbx]      ; rcx = contents at address in rbx (99)
    mov     eax, 99
    ret
ex_04_mov_vs_lea ENDP
main PROC
    sub     rsp, 40
    call    ex_04_mov_vs_lea
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
