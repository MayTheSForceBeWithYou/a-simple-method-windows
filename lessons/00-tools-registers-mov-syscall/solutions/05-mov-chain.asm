; Exercise 05: mov chain
;
; Set al=3, bl=5, cl=7. Sum into dil, movzx to rdi, exit (expect 15).
;
; Build: ml64 /c 05-mov-chain.asm && link /OUT:05-mov-chain.exe /ENTRY:main /SUBSYSTEM:CONSOLE 05-mov-chain.obj kernel32.lib
;
; Expected exit: 15

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov al, 3
    mov bl, 5
    mov cl, 7
    mov dil, al
    add dil, bl
    add dil, cl
    movzx rcx, dil
    call ExitProcess
main ENDP
END
