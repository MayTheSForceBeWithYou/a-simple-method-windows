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

ex_01_buffer_init PROC
mov QWORD PTR [len], 0
    mov rcx, [len]
    mov     eax, [len]
    ret
ex_01_buffer_init ENDP
main PROC
    sub     rsp, 40
    call    ex_01_buffer_init
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
