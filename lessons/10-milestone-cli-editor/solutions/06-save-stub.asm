; Exercise 06: save stub
;
; Pretend save ok; exit 0.
;
; Build: ml64 /c 06-save-stub.asm && link /OUT:06-save-stub.exe /ENTRY:main /SUBSYSTEM:CONSOLE 06-save-stub.obj kernel32.lib
;
; Expected exit: 0

EXTERN ExitProcess:PROC

.code
ex_06_save_stub PROC
    sub rsp, 40
        mov     eax, 0
    ret
    add     rsp, 40
ex_06_save_stub ENDP
main PROC
    call    ex_06_save_stub
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
