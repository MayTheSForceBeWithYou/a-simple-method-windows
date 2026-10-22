; Exercise 06: eax zero extends
;
; Set rax to all 0xFF bytes, then mov eax, 1. Exit with rcx=rax (should be 1).
;
; Build: ml64 /c 06-eax-zero-extends.asm && link /OUT:06-eax-zero-extends.exe /ENTRY:main /SUBSYSTEM:CONSOLE 06-eax-zero-extends.obj kernel32.lib
;
; Expected exit: 1

EXTERN ExitProcess:PROC

.code
ex_06_eax_zero_extends PROC
    sub rsp, 40
    mov rax, 0FFFFFFFFFFFFFFFFh
    mov eax, 1
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_06_eax_zero_extends ENDP
main PROC
    sub     rsp, 40
    call    ex_06_eax_zero_extends
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
