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
    sub rsp, 40
    
    mov QWORD PTR [len], 0
        mov     eax, [len]
    ret
    add     rsp, 40
ex_01_buffer_init ENDP
main PROC
    call    ex_01_buffer_init
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
