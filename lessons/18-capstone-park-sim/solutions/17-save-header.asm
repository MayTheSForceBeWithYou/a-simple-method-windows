; Exercise 17: save header
;
; Write magic+version size 8; exit 8.
;
; Build: ml64 /c 17-save-header.asm && link /OUT:17-save-header.exe /ENTRY:main /SUBSYSTEM:CONSOLE 17-save-header.obj kernel32.lib
;
; Expected exit: 8
; Expected stdout: (none)
;

EXTERN ExitProcess:PROC

.code
ex_17_save_header PROC
    sub rsp, 40
        mov     eax, 8
    add     rsp, 40
    ret
ex_17_save_header ENDP
main PROC
    call    ex_17_save_header
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
