; Exercise 28: from scratch swap
;
; FROM SCRATCH: a QWORD 1 / b QWORD 2. Swap via registers; exit with rcx=a (should be 2).
;
; Build: ml64 /c 28-from-scratch-swap.asm && link /OUT:28-from-scratch-swap.exe /ENTRY:main /SUBSYSTEM:CONSOLE 28-from-scratch-swap.obj kernel32.lib
;
; Expected exit: 2

EXTERN ExitProcess:PROC

.data
a QWORD 1
b QWORD 2

.code
main PROC
    sub rsp, 40
    mov rax, [a]
    mov rdx, [b]
    mov [a], rdx
    mov [b], rax
    mov rcx, [a]
    call ExitProcess
main ENDP
END
