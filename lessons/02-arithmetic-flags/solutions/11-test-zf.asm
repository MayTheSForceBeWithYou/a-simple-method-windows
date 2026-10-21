; Exercise 11: test zf
;
; rax=0; test rax,rax; sete al; exit 1.
;
; Build: ml64 /c 11-test-zf.asm && link /OUT:11-test-zf.exe /ENTRY:main /SUBSYSTEM:CONSOLE 11-test-zf.obj kernel32.lib
;
; Expected exit: 1

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    xor rax, rax
    test rax, rax
    sete al
    movzx rcx, al
    call ExitProcess
main ENDP
END
