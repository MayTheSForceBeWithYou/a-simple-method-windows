; Exercise 09: key down up
;
; Track key state: down sets, up clears; exit 0.
;
; Build: ml64 /c 09-key-down-up.asm && link /OUT:09-key-down-up.exe /ENTRY:main /SUBSYSTEM:CONSOLE 09-key-down-up.obj kernel32.lib
;
; Expected exit: 0
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data?
key_w BYTE ?

.code
ex_09_key_down_up PROC
    sub rsp, 40
    mov BYTE PTR [key_w], 1
    mov BYTE PTR [key_w], 0
    movzx rcx, BYTE PTR [key_w]
    mov     eax, 0
    ret
ex_09_key_down_up ENDP
main PROC
    call    ex_09_key_down_up
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
