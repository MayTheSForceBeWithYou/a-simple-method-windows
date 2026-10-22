; Exercise 05: save magic
;
; Magic 'PK01' first byte 'P'=80; exit 80.
;
; Build: ml64 /c 05-save-magic.asm && link /OUT:05-save-magic.exe /ENTRY:main /SUBSYSTEM:CONSOLE 05-save-magic.obj kernel32.lib
;
; Expected exit: 80
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
magic BYTE "PK01"

.code
ex_05_save_magic PROC
    sub rsp, 40
    movzx rcx, BYTE PTR [magic]
    mov     eax, 80
    add     rsp, 40
    ret
ex_05_save_magic ENDP
main PROC
    sub     rsp, 40
    call    ex_05_save_magic
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
