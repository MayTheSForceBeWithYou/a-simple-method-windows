; Exercise 20: alpha stub
;
; Alpha blend stub: out=src if a=255; exit 7.
;
; Build: ml64 /c 20-alpha-stub.asm && link /OUT:20-alpha-stub.exe /ENTRY:main /SUBSYSTEM:CONSOLE 20-alpha-stub.obj kernel32.lib
;
; Expected exit: 7
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_20_alpha_stub PROC
    sub rsp, 40
        mov     eax, ecx
    add     rsp, 40
    ret
ex_20_alpha_stub ENDP
main PROC
    sub     rsp, 40
    call    ex_20_alpha_stub
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
