; Exercise 11: debug size
;
; BUG: mov [buf], 1 ambiguous/wrong. Store BYTE 1, load movzx rcx, exit.
;
; Build: ml64 /c 11-debug-size.asm && link /OUT:11-debug-size.exe /ENTRY:main /SUBSYSTEM:CONSOLE 11-debug-size.obj kernel32.lib
;
; Expected exit: 1

EXTERN ExitProcess:PROC

.data?
buf BYTE ?

.code
ex_11_debug_size PROC
    sub rsp, 40
    mov BYTE PTR [buf], 1
    movzx rcx, BYTE PTR [buf]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_11_debug_size ENDP
main PROC
    sub     rsp, 40
    call    ex_11_debug_size
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
